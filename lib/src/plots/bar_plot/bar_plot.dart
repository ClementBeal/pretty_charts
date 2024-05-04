import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pretty_charts/src/axes/axes.dart';
import 'package:pretty_charts/src/axes/plot_framework.dart';
import 'package:pretty_charts/src/plots/bar_plot/bar_plot_data.dart';
import 'package:pretty_charts/src/shared/chart_viewer.dart';
import 'package:pretty_charts/src/shared/color_maps/color_map.dart';
import 'package:pretty_charts/src/shared/color_maps/qualitative_color_map.dart';

class BarPlot extends StatefulWidget {
  const BarPlot({
    super.key,
    required this.axes,
    required this.data,
    this.colorMap,
    this.animationDuration = Durations.extralong1,
    this.animationCurve = Curves.easeInOut,
  });

  final CartesianAxes axes;
  final List<BarPlotData> data;
  final Duration animationDuration;
  final Curve animationCurve;
  final ColorMap? colorMap;

  @override
  State<BarPlot> createState() => _BarPlotState();
}

class _BarPlotState extends State<BarPlot> with SingleTickerProviderStateMixin {
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
      child: ClipRect(
        child: CustomPaint(
          painter: BarPlotPainter(
            scaleFactor: _scaleFactor,
            axes: widget.axes,
            animationProgress: _progressAnimation.value,
            offset: _offset,
            data: widget.data,
            colorMap: widget.colorMap ?? pastel1,
          ),
          foregroundPainter: PlotFrameworkPainter(
            scaleFactor: _scaleFactor,
            axes: widget.axes,
            offset: _offset,
          ),
        ),
      ),
    );
  }
}

class BarPlotPainter extends CustomPainter {
  BarPlotPainter({
    super.repaint,
    required this.axes,
    required this.animationProgress,
    required this.scaleFactor,
    required this.offset,
    required this.data,
    required this.colorMap,
  });

  final CartesianAxes axes;
  final double scaleFactor;
  final Offset offset;
  final List<BarPlotData> data;
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

    final xAxesNumberTicks = axes.numberOfTicksOnX;
    final yAxesNumberTicks = axes.numberOfTicksOnY;
    final xAxesRange = axes.xLimits.translate(offset.dx).scale(scaleFactor);
    final yAxesRange = axes.yLimits.translate(-offset.dy).scale(scaleFactor);

    final height = size.height;
    final width = size.width;

    final paddedWidth = size.width - 2 * internalPadding;
    final paddedHeight = size.height - 2 * internalPadding;

    final axesOrigin = Offset(
      internalPadding + axesPadding,
      size.height - internalPadding - axesPadding,
    );

    final axesWidth = paddedWidth - 2 * axesPadding;
    final axesHeight = paddedHeight - 2 * axesPadding;

    final curvePainterBackGround = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.fill;

    final curvePainter = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final maxValue = data.map((e) => e.y.max).max;

    const barSpacing = 20;
    final xTotalElements = data.map((e) => e.x).flattened.toSet().length;

    // (barSpacing + barWith) * xTotalElements = axesWidth
    final barWidth = (axesWidth / xTotalElements - barSpacing);

    for (var d in data) {
      final barPaths = <Path>[];
      final totalElement = d.x.length;

      for (var i = 0; i < totalElement; i++) {
        final barHeight = (d.y[i] / maxValue) * axesHeight;
        final curvePath = Path();

        curvePath.addRect(
          Rect.fromLTWH(
            axesOrigin.dx + i * (barSpacing + barWidth),
            axesOrigin.dy,
            barWidth,
            -barHeight,
          ),
        );
        barPaths.add(curvePath);
      }

      for (var (i, curvePath) in barPaths.indexed) {
        final color = colorMap.getColor(i / totalElement);
        curvePainterBackGround.color = color.withOpacity(0.4);
        curvePainter.color = color;
        canvas.drawPath(curvePath, curvePainterBackGround);
        canvas.drawPath(curvePath, curvePainter);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
