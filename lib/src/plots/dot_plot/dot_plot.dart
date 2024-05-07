import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';
import 'package:pretty_charts/src/shared/chart_viewer.dart';
import 'package:pretty_charts/src/shared/color_maps/color_map.dart';

class DotPlot extends StatefulWidget {
  const DotPlot({
    super.key,
    required this.data,
    this.colorMap,
    this.animationDuration = Durations.extralong1,
    this.animationCurve = Curves.easeInOut,
    required this.axes,
  });

  final List<DotPlotData> data;
  final Duration animationDuration;
  final Curve animationCurve;
  final ColorMap? colorMap;
  final CartesianAxes axes;

  @override
  State<DotPlot> createState() => _DotPlotState();
}

class _DotPlotState extends State<DotPlot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  double _scaleFactor = 1.0;
  Offset _offset = Offset.zero;

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

    _controller.forward();
  }

  @override
  void dispose() {
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
      child: LayoutBuilder(
        builder: (context, constraints) => ClipRect(
          child: CustomPaint(
            size: Size(constraints.maxWidth, constraints.maxHeight),
            painter: DotPlotPainter(
              scaleFactor: _scaleFactor,
              animationProgress: _progressAnimation.value,
              offset: _offset,
              data: widget.data,
              colorMap: widget.colorMap ?? pastel1,
              axes: widget.axes,
            ),
          ),
        ),
      ),
    );
  }
}

class DotPlotPainter extends CustomPainter {
  DotPlotPainter({
    super.repaint,
    required this.animationProgress,
    required this.scaleFactor,
    required this.offset,
    required this.data,
    required this.colorMap,
    required this.axes,
  });

  final double scaleFactor;
  final Offset offset;
  final List<DotPlotData> data;
  final ColorMap colorMap;
  final CartesianAxes axes;

  /// progress value of the animation
  /// 0 is the start || 1 is the end
  /// interval of value : [0, 1]
  final double animationProgress;

  @override
  void paint(Canvas canvas, Size size) {
    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 18,
    );

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.right,
    );

    final backgroundPointPainter = Paint()
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    final borderPointPainter = Paint()
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final gridPainter = Paint()
      ..strokeWidth = 1
      ..color = Colors.grey.shade800;

    var totalTextHeight = 0.0;
    final maxTextWidth = data.map((e) {
      textPainter.text = TextSpan(
        text: e.name,
        style: textStyle,
      );
      textPainter.layout();
      totalTextHeight += textPainter.height;
      return textPainter.width;
    }).fold(double.negativeInfinity,
        (previousValue, element) => math.max(previousValue, element));

    final colors = data.first.data.map((e) => colorMap.getColor(0)).toList();

    final barMaxWidth = size.width - maxTextWidth;

    final flattenedData = data.map((e) => e.data).flattened;
    var tmpMinValue = flattenedData.min;
    var tmpMaxValue = flattenedData.max;

    final minValue = tmpMinValue - (tmpMaxValue - tmpMinValue) * 0.1;
    final maxValue = tmpMaxValue + (tmpMaxValue - tmpMinValue) * 0.1;

    for (var i = 0; i < axes.numberOfTicksOnX - 1; i++) {
      canvas.drawLine(
        Offset(
          maxTextWidth + (i + 1) * barMaxWidth / axes.numberOfTicksOnX,
          0,
        ),
        Offset(
          maxTextWidth + (i + 1) * barMaxWidth / axes.numberOfTicksOnX,
          totalTextHeight,
        ),
        borderPointPainter,
      );

      final yAxesValue =
          minValue + (i + 1) * (maxValue - minValue) / (axes.numberOfTicksOnX);

      textPainter.text = TextSpan(
        text: axes.xLabelsBuilder?.call(yAxesValue) ?? "$yAxesValue",
        style: textStyle,
      );
      textPainter.layout();

      textPainter.paint(
        canvas,
        Offset(
          maxTextWidth +
              (i + 1) * barMaxWidth / axes.numberOfTicksOnX -
              textPainter.width / 2,
          totalTextHeight,
        ),
      );
    }

    double height = 0;

    for (var (_, d) in data.indexed) {
      textPainter.text = TextSpan(
        text: d.name,
        style: textStyle,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          maxTextWidth - textPainter.width,
          height,
        ),
      );

      canvas.drawLine(
          Offset(
            maxTextWidth,
            height + textPainter.height / 2,
          ),
          Offset(
            size.width * animationProgress,
            height + textPainter.height / 2,
          ),
          gridPainter);

      for (var (id, value) in d.data.indexed) {
        final normalizedValue = (value - minValue) / (maxValue - minValue);
        borderPointPainter.color = colors[id];
        backgroundPointPainter.color = colors[id];

        canvas.drawCircle(
          Offset(
            maxTextWidth + normalizedValue * barMaxWidth,
            height + textPainter.height / 2,
          ),
          4 * animationProgress,
          backgroundPointPainter,
        );
        canvas.drawCircle(
          Offset(
            maxTextWidth + normalizedValue * barMaxWidth,
            height + textPainter.height / 2,
          ),
          4 * animationProgress,
          borderPointPainter,
        );
      }
      height += textPainter.height;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
