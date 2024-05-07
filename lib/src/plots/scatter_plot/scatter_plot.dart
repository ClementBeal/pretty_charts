import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';
import 'package:pretty_charts/src/axes/plot_framework.dart';
import 'package:pretty_charts/src/shared/chart_viewer.dart';
import 'package:pretty_charts/src/shared/color_maps/color_map.dart';

class ScatterPlot extends StatefulWidget {
  const ScatterPlot({
    super.key,
    required this.data,
    this.colorMap,
    this.animationDuration = Durations.extralong1,
    this.animationCurve = Curves.easeInOut,
    required this.axes,
  });

  final List<ScatterPlotData> data;
  final Duration animationDuration;
  final Curve animationCurve;
  final ColorMap? colorMap;
  final CartesianAxes axes;

  @override
  State<ScatterPlot> createState() => _ScatterPlotState();
}

class _ScatterPlotState extends State<ScatterPlot>
    with SingleTickerProviderStateMixin {
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
            painter: ScatterPlotPainter(
              scaleFactor: _scaleFactor,
              animationProgress: _progressAnimation.value,
              offset: _offset,
              data: widget.data,
              colorMap: widget.colorMap ?? pastel1,
              axes: widget.axes,
            ),
            foregroundPainter: PlotFrameworkPainter(
              axes: widget.axes,
              scaleFactor: _scaleFactor,
              offset: _offset,
            ),
          ),
        ),
      ),
    );
  }
}

class ScatterPlotPainter extends CustomPainter {
  ScatterPlotPainter({
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
  final List<ScatterPlotData> data;
  final ColorMap colorMap;
  final CartesianAxes axes;

  /// progress value of the animation
  /// 0 is the start || 1 is the end
  /// interval of value : [0, 1]
  final double animationProgress;

  @override
  void paint(Canvas canvas, Size size) {
    const double internalPadding = 50.0;
    const double axesPadding = 20.0;

    colorMap.reset();

    final axesOrigin = Offset(internalPadding, size.height - internalPadding);
    final plotOrigin = axesOrigin + const Offset(axesPadding, -axesPadding);

    final xAxesRange = axes.xLimits.translate(offset.dx).scale(scaleFactor);
    final yAxesRange = axes.yLimits.translate(-offset.dy).scale(scaleFactor);

    final axesWidth = size.width - 2 * (internalPadding + axesPadding);
    final axesHeight = size.height - 2 * (internalPadding + axesPadding);

    final pointPaiter = Paint()
      ..strokeWidth = 12.0 * animationProgress
      ..strokeCap = StrokeCap.round;

    for (var (i, d) in data.indexed) {
      pointPaiter.color = colorMap.getColor(i.toDouble()).withOpacity(0.4);

      final points = Float32List(d.x.length + d.y.length);
      for (var i = 0; i < d.x.length; i++) {
        points[i * 2] = plotOrigin.dx +
            axesWidth *
                (offset.dx + d.x[i]) /
                xAxesRange.getDiff() *
                scaleFactor;
        points[i * 2 + 1] = plotOrigin.dy -
            axesHeight *
                (-offset.dy + d.y[i]) /
                yAxesRange.getDiff() *
                scaleFactor;
      }

      canvas.clipRect(
        Rect.fromLTWH(
          internalPadding,
          internalPadding,
          size.width - 2 * internalPadding,
          size.height - 2 * internalPadding,
        ),
      );
      canvas.drawRawPoints(PointMode.points, points, pointPaiter);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
