import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';
import 'package:pretty_charts/src/shared/chart_viewer.dart';
import 'package:pretty_charts/src/shared/color_maps/color_map.dart';

import 'dart:math' as math;

class PiePlot extends StatefulWidget {
  const PiePlot({
    super.key,
    required this.data,
    this.colorMap,
    this.animationDuration = Durations.extralong1,
    this.animationCurve = Curves.easeInOut,
    this.config = const PiePlotConfig(),
  });

  final List<PiePlotData> data;
  final Duration animationDuration;
  final Curve animationCurve;
  final ColorMap? colorMap;
  final PiePlotConfig config;

  @override
  State<PiePlot> createState() => _PiePlotState();
}

class _PiePlotState extends State<PiePlot> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _selectedController;
  late Animation<double> _progressAnimation;
  late Animation<double> _selectedAnimation;

  double _scaleFactor = 1.0;
  Offset _offset = Offset.zero;
  Offset _previousTapOffset = Offset.zero;
  Offset _tapOffset = Offset.zero;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..addListener(() {
        setState(() {});
      });

    _selectedController = AnimationController(
      vsync: this,
      duration: Durations.medium1,
    )..addListener(() {
        setState(() {});
      });

    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.animationCurve,
      ),
    );

    _selectedAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _selectedController,
        curve: widget.animationCurve,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _selectedController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChartViewer(
      initialScale: 1.0,
      onScale: (double scaleFactor, Offset offset) {
        setState(() {
          _scaleFactor = scaleFactor;
          _offset = offset;
        });
      },
      onTapUp: (details) {
        _selectedController.forward(from: 0);

        setState(() {
          _previousTapOffset = _tapOffset;
          _tapOffset = details.localPosition;
        });
      },
      child: LayoutBuilder(
        builder: (context, constraints) => ClipRect(
          child: CustomPaint(
            size: Size(constraints.maxWidth, constraints.maxHeight),
            painter: PiePlotPainter(
              config: widget.config,
              scaleFactor: _scaleFactor,
              animationProgress: _progressAnimation.value,
              selectedProgress: _selectedAnimation.value,
              offset: _offset,
              data: widget.data,
              colorMap: widget.colorMap ?? pastel1,
              tapOffset: _tapOffset,
              previousTapOffset: _previousTapOffset,
            ),
          ),
        ),
      ),
    );
  }
}

class PiePlotPainter extends CustomPainter {
  PiePlotPainter({
    super.repaint,
    required this.animationProgress,
    required this.scaleFactor,
    required this.offset,
    required this.data,
    required this.colorMap,
    required this.config,
    required this.tapOffset,
    required this.previousTapOffset,
    required this.selectedProgress,
  });

  final double scaleFactor;
  final Offset offset;
  final List<PiePlotData> data;
  final ColorMap colorMap;
  final PiePlotConfig config;

  final Offset tapOffset;
  final Offset previousTapOffset;

  /// progress value of the animation
  /// 0 is the start || 1 is the end
  /// interval of value : [0, 1]
  final double animationProgress;
  final double selectedProgress;

  @override
  void paint(Canvas canvas, Size size) {
    colorMap.reset();
    const internalPadding = 30.0;
    final Offset canvasCenter;

    final dimension = math.min(size.width, size.height);

    if (config.title != null) {
      final a = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(text: config.title!, style: config.titleStyle),
      )..layout(maxWidth: dimension);

      canvasCenter = Offset(size.width / 2, a.height + dimension / 2);
    } else {
      canvasCenter = Offset(size.width / 2, dimension / 2);
    }

    final pieWidth = dimension - 2 * internalPadding;
    final pieHeight = dimension - 2 * internalPadding;

    final curvePainterBackGround = Paint()..style = PaintingStyle.fill;
    final curvePainterBorder = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final labelPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    final double valueSum = data.fold(
        0.0, (previousValue, element) => previousValue + element.value);

    var currentAngle = config.startAngle;

    for (var (i, e) in data.indexed) {
      var path = Path();
      final normalizedValue = e.value / valueSum;
      final angle = 2 * math.pi * normalizedValue * animationProgress;

      curvePainterBackGround.color =
          colorMap.getColor(i / data.length).withOpacity(0.3);
      curvePainterBorder.color = colorMap.getColor(i / data.length);

      // move to the farthest point
      path.moveTo(
        canvasCenter.dx +
            math.cos(currentAngle) * pieWidth * config.holeRadiusRatio,
        canvasCenter.dy +
            math.sin(currentAngle) * pieHeight * config.holeRadiusRatio,
      );

      // // draw an arc
      path.arcTo(
        Rect.fromCenter(
          center: canvasCenter,
          width: pieWidth,
          height: pieHeight,
        ),
        currentAngle,
        angle,
        false,
      );

      // // move to the the smaller arc extremity
      path.lineTo(
        canvasCenter.dx +
            math.cos(currentAngle + angle) * pieWidth * config.holeRadiusRatio,
        canvasCenter.dy +
            math.sin(currentAngle + angle) * pieHeight * config.holeRadiusRatio,
      );

      // // close the path with an arc
      path.arcTo(
        Rect.fromCenter(
          center: canvasCenter,
          width: pieWidth * config.holeRadiusRatio,
          height: pieHeight * config.holeRadiusRatio,
        ),
        currentAngle + angle,
        -angle,
        false,
      );
      path.close();

      // how to find the arc center
      // we get the X and Y of the line at the half angle -> currentAngle + angle / 2
      // multiply by the pie width
      // we have to add an offset if the hole radius is bigger than 0
      // that's why we have (1 + config.holeRadiusRatio)
      // we have the position of the middle point of the arc
      // we divide by 2 to get the center of the arc area
      final arcCenter = (Offset(
                canvasCenter.dx +
                    math.cos(currentAngle + angle / 2) *
                        pieWidth *
                        (1 + config.holeRadiusRatio) /
                        2,
                canvasCenter.dy +
                    math.sin(currentAngle + angle / 2) *
                        pieHeight *
                        (1 + config.holeRadiusRatio) /
                        2,
              ) +
              canvasCenter) /
          2;

      var a = path.contains(previousTapOffset);
      var b = path.contains(tapOffset);

      if (a) {
        final newArcCenter = (Offset(
                  canvasCenter.dx +
                      math.cos(currentAngle + angle / 2) *
                          pieWidth *
                          (1 + 0.2 * (1 - selectedProgress)) *
                          (1 + config.holeRadiusRatio) /
                          2,
                  canvasCenter.dy +
                      math.sin(currentAngle + angle / 2) *
                          pieHeight *
                          (1 + 0.2 * (1 - selectedProgress)) *
                          (1 + config.holeRadiusRatio) /
                          2,
                ) +
                canvasCenter) /
            2;
        final diff = newArcCenter - arcCenter;
        final transformationMatrix =
            Matrix4.translationValues(diff.dx, diff.dy, 0);
        path = path.transform(transformationMatrix.storage);
      }
      if (b && !a) {
        final newArcCenter = (Offset(
                  canvasCenter.dx +
                      math.cos(currentAngle + angle / 2) *
                          pieWidth *
                          (1 + 0.2 * selectedProgress) *
                          (1 + config.holeRadiusRatio) /
                          2,
                  canvasCenter.dy +
                      math.sin(currentAngle + angle / 2) *
                          pieHeight *
                          (1 + 0.2 * selectedProgress) *
                          (1 + config.holeRadiusRatio) /
                          2,
                ) +
                canvasCenter) /
            2;
        final diff = newArcCenter - arcCenter;
        final transformationMatrix =
            Matrix4.translationValues(diff.dx, diff.dy, 0);
        path = path.transform(transformationMatrix.storage);
      }

      canvas.drawPath(path, curvePainterBackGround);

      if (config.drawBorders) {
        canvas.drawPath(path, curvePainterBorder);
      }

      if (config.showLabels) {
        final String text;

        if (config.onGenerateLabels != null) {
          final percentage = (config.totalValue != null)
              ? e.value / config.totalValue!
              : normalizedValue;
          text = config.onGenerateLabels!(e.value, percentage, e.name);
        } else {
          text = e.name;
        }

        labelPainter.text = TextSpan(
          text: text,
          style: config.labelStyle.copyWith(
              fontSize: config.labelStyle.fontSize! * animationProgress),
        );
        labelPainter.layout();

        labelPainter.paint(
          canvas,
          arcCenter - Offset(labelPainter.width / 2, labelPainter.height / 2),
        );
      }

      currentAngle += angle;
    }

    if (config.title != null) {
      final titlePainter = TextPainter(
        text: TextSpan(
          text: config.title,
          style: config.titleStyle,
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );

      if (config.centeredTitle) {
        titlePainter.layout(maxWidth: pieWidth * config.holeRadiusRatio);
        titlePainter.paint(
          canvas,
          canvasCenter -
              Offset(titlePainter.width / 2, titlePainter.height / 2),
        );
      } else {
        titlePainter.layout(maxWidth: pieWidth);
        titlePainter.paint(
          canvas,
          Offset(
              size.width / 2 - titlePainter.width / 2, titlePainter.height / 2),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is PiePlotPainter) {
      // Check if any of the parameters that affect the appearance have changed
      return oldDelegate.scaleFactor != scaleFactor ||
          oldDelegate.offset != offset ||
          oldDelegate.tapOffset != tapOffset ||
          oldDelegate.previousTapOffset != previousTapOffset ||
          oldDelegate.animationProgress != animationProgress ||
          oldDelegate.selectedProgress != selectedProgress;
    }
    return true;
  }
}
