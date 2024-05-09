import 'package:flutter/material.dart';
import 'package:pretty_charts/src/axes/axes.dart';
import 'package:pretty_charts/src/axes/plot_framework.dart';
import 'package:pretty_charts/src/plots/line_plot/line_plot_data.dart';
import 'package:pretty_charts/src/shared/chart_viewer.dart';
import 'package:pretty_charts/src/shared/color_maps/color_map.dart';
import 'package:pretty_charts/src/shared/color_maps/qualitative_color_map.dart';

class LinePlot extends StatefulWidget {
  const LinePlot({
    super.key,
    required this.axes,
    required this.data,
    this.animationDuration = Durations.extralong1,
    this.animationCurve = Curves.easeInOut,
    this.showPoints = false,
    this.colorMap,
  });

  final CartesianAxes axes;
  final List<LinePlotData> data;
  final Duration animationDuration;
  final Curve animationCurve;
  final bool showPoints;
  final ColorMap? colorMap;

  @override
  State<LinePlot> createState() => _LinePlotState();
}

class _LinePlotState extends State<LinePlot> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  late AnimationController _selectedPointController;
  Animation<Offset>? _selectedPointAnimation;

  double _scaleFactor = 1.0;
  Offset _offset = Offset.zero;
  Offset? _tappedPosition;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..addListener(() {
        setState(() {});
      });

    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.animationCurve,
      ),
    );

    _selectedPointController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _selectedPointController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ChartViewer(
          initialScale: 1.0,
          onScale: (double scaleFactor, Offset offset) {
            setState(() {
              _scaleFactor = scaleFactor;
              _offset = offset;
            });
          },
          onTapUp: (details) {
            _selectedPointAnimation?.removeListener(() {});

            if (_tappedPosition != null) {
              _selectedPointAnimation = Tween<Offset>(
                      begin: _tappedPosition, end: details.localPosition)
                  .animate(
                CurvedAnimation(
                  parent: _selectedPointController,
                  curve: widget.animationCurve,
                ),
              )..addListener(() {
                  setState(() {
                    _tappedPosition = _selectedPointAnimation?.value;
                  });
                });

              _selectedPointController.forward(from: 0);
            }

            setState(() {
              _tappedPosition = details.localPosition;
            });
          },
          child: ClipRect(
            child: CustomPaint(
              size: Size(constraints.maxWidth, constraints.maxHeight),
              foregroundPainter: LinePlotPainter(
                scaleFactor: _scaleFactor,
                axes: widget.axes,
                animationProgress: _progressAnimation.value,
                offset: _offset,
                data: widget.data,
                tappedPosition: _tappedPosition,
                showPoints: widget.showPoints,
                colorMap: widget.colorMap ?? pastel17,
              ),
              painter: PlotFrameworkPainter(
                scaleFactor: _scaleFactor,
                axes: widget.axes,
                offset: _offset,
              ),
            ),
          ),
        );
      },
    );
  }
}

class LinePlotPainter extends CustomPainter {
  LinePlotPainter({
    super.repaint,
    required this.axes,
    required this.animationProgress,
    required this.scaleFactor,
    required this.offset,
    required this.data,
    required this.tappedPosition,
    required this.showPoints,
    required this.colorMap,
  });

  final CartesianAxes axes;
  final double scaleFactor;
  final Offset offset;
  final List<LinePlotData> data;

  final Offset? tappedPosition;
  final bool showPoints;
  final ColorMap colorMap;

  /// progress value of the animation
  /// 0 is the start || 1 is the end
  /// interval of value : [0, 1]
  final double animationProgress;

  @override
  void paint(Canvas canvas, Size size) {
    colorMap.reset();
    const double internalPadding = 50.0;
    const double axesPadding = 20.0;

    final xAxesRange =
        axes.xLimits.translate(-offset.dx / 100).scale(scaleFactor);
    final yAxesRange =
        axes.yLimits.translate(offset.dy / 100).scale(scaleFactor);

    final height = size.height;

    final paddedWidth = size.width - 2 * internalPadding;
    final paddedHeight = size.height - 2 * internalPadding;

    final axesOrigin = Offset(
      internalPadding + axesPadding,
      size.height - internalPadding - axesPadding,
    );

    final axesWidth = paddedWidth - 2 * axesPadding;
    final axesHeight = paddedHeight - 2 * axesPadding;

    // draw a curve
    for (var d in data) {
      final int points = d.x?.length ?? 300;

      var curvePath = Path();
      final curvePainter = Paint()
        ..color = colorMap.getColor(0)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;

      final curveStep = axesWidth / points;

      bool hasDrawFirstPoint = false;

      for (var i = 0; i < points; i++) {
        final double x;
        final double y;

        if (d.x != null && d.y != null) {
          x = d.x![i];
          y = d.y![i];
        } else {
          x = xAxesRange.minLimit + i * xAxesRange.getDiff() / points;
          y = d.onGenerateY!(x);
        }

        final translatedX = axesOrigin.dx + i * curveStep;

        final translatedY = axesOrigin.dy -
            y / yAxesRange.getDiff() * axesHeight +
            yAxesRange.minLimit *
                axesHeight /
                (yAxesRange.maxLimit - yAxesRange.minLimit);

        if (showPoints) {
          canvas.drawCircle(Offset(translatedX, translatedY), 6, curvePainter);
          canvas.drawCircle(Offset(translatedX, translatedY), 6, curvePainter);
        }

        if (hasDrawFirstPoint) {
          curvePath.lineTo(
            translatedX,
            translatedY,
          );
        } else {
          yAxesRange.minLimit * axesHeight / yAxesRange.getDiff();
          curvePath.moveTo(
            translatedX,
            translatedY,
          );
          hasDrawFirstPoint = true;
        }
      }

      final totalLength = curvePath
          .computeMetrics()
          .fold(0.0, (prev, metric) => prev + metric.length);

      final currentLength = totalLength * animationProgress;

      var extractedPath = extractPathUntilLength(curvePath, currentLength);

      switch (d.lineStyle) {
        case LineStyle.solid:
          break;
        case LineStyle.dashed:
          extractedPath = useDashedLine(extractedPath, 12, 8);
          break;
        case LineStyle.point:
          extractedPath = usePointLine(extractedPath);
          break;
      }

      canvas.clipRect(
        Rect.fromLTWH(
          internalPadding,
          height - internalPadding,
          paddedWidth,
          -paddedHeight,
        ),
      );
      canvas.drawPath(extractedPath, curvePainter);
    }

    if (tappedPosition != null) {
      final cursorPainter = Paint()..style = PaintingStyle.fill;
      final borderCursorPainter = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;

      colorMap.reset();
      for (var d in data) {
        final color = colorMap.getColor(0);
        cursorPainter.color = color.withOpacity(0.4);
        borderCursorPainter.color = color;

        final double x;
        final double y;

        if (d.onGenerateY != null) {
          x = xAxesRange.minLimit +
              (tappedPosition!.dx - axesOrigin.dx) /
                  axesWidth *
                  xAxesRange.getDiff();
          y = d.onGenerateY!(x);
        } else {
          x = d.x![0];
          y = d.y![0];
        }
        final translatedX =
            axesOrigin.dx + (tappedPosition!.dx - axesOrigin.dx);

        final translatedY = axesOrigin.dy -
            y / yAxesRange.getDiff() * axesHeight +
            yAxesRange.minLimit *
                axesHeight /
                (yAxesRange.maxLimit - yAxesRange.minLimit);

        canvas.drawCircle(Offset(translatedX, translatedY), 6, cursorPainter);
        canvas.drawCircle(
            Offset(translatedX, translatedY), 6, borderCursorPainter);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

Path usePointLine(Path originalPath) {
  return useDashedLine(originalPath, 2, 2);
}

Path useDashedLine(Path originalPath, double dashLength, double dashSpacing) {
  final path = Path();
  var metrics = originalPath.computeMetrics();
  var metricsIterator = metrics.iterator;

  while (metricsIterator.moveNext()) {
    var metric = metricsIterator.current;

    double offset = 0;
    while (offset * (dashSpacing + dashLength) < metric.length) {
      var extractedPath = metric.extractPath(
        offset * (dashSpacing + dashLength),
        offset * (dashSpacing + dashLength) + dashLength,
      );
      offset += 1;

      path.addPath(extractedPath, Offset.zero);
    }
  }

  return path;
}

Path extractPathUntilLength(
  Path originalPath,
  double length,
) {
  var currentLength = 0.0;

  final path = Path();

  var metricsIterator = originalPath.computeMetrics().iterator;

  while (metricsIterator.moveNext()) {
    var metric = metricsIterator.current;

    var nextLength = currentLength + metric.length;

    final isLastSegment = nextLength > length;
    if (isLastSegment) {
      final remainingLength = length - currentLength;
      final pathSegment = metric.extractPath(0.0, remainingLength);

      path.addPath(pathSegment, Offset.zero);
      break;
    } else {
      // There might be a more efficient way of extracting an entire path
      final pathSegment = metric.extractPath(0.0, metric.length);
      path.addPath(pathSegment, Offset.zero);
    }

    currentLength = nextLength;
  }

  return path;
}
