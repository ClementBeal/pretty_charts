import 'package:flutter/material.dart';
import 'package:pretty_charts/src/axes/axes.dart';
import 'package:pretty_charts/src/axes/plot_framework.dart';
import 'package:pretty_charts/src/plots/line_plot/line_plot_data.dart';
import 'package:pretty_charts/src/shared/chart_viewer.dart';

class LinePlot extends StatefulWidget {
  const LinePlot({
    super.key,
    required this.axes,
    required this.data,
  });

  final Axes axes;
  final List<LinePlotData> data;

  @override
  State<LinePlot> createState() => _LinePlotState();
}

class _LinePlotState extends State<LinePlot>
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
      duration: Durations.extralong4,
    )..addListener(() {
        setState(() {});
      });

    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
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
          painter: LinePlotPainter(
            scaleFactor: _scaleFactor,
            axes: widget.axes,
            animationProgress: _progressAnimation.value,
            offset: _offset,
            data: widget.data,
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

class LinePlotPainter extends CustomPainter {
  LinePlotPainter({
    super.repaint,
    required this.axes,
    required this.animationProgress,
    required this.scaleFactor,
    required this.offset,
    required this.data,
  });

  final Axes axes;
  final double scaleFactor;
  final Offset offset;
  final List<LinePlotData> data;

  /// progress value of the animation
  /// 0 is the start || 1 is the end
  /// interval of value : [0, 1]
  final double animationProgress;

  @override
  void paint(Canvas canvas, Size size) {
    const double internalPadding = 50.0;
    const double axesPadding = 20.0;
    const int points = 300;

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

    // draw a curve
    for (var d in data) {
      final curvePath = Path();
      final curvePainter = Paint()
        ..color = d.lineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;

      final curveStep = axesWidth / points;

      bool hasDrawFirstPoint = false;

      for (var i = 0; i < points + 1; i++) {
        final x = xAxesRange.minLimit + i * xAxesRange.getDiff() / points;
        final y = d.onGenerate(x);

        final translatedX = axesOrigin.dx + i * curveStep;

        final translatedY = axesOrigin.dy -
            y / yAxesRange.getDiff() * axesHeight +
            yAxesRange.minLimit *
                axesHeight /
                (yAxesRange.maxLimit - yAxesRange.minLimit);

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

      final extractedPath = extractPathUntilLength(curvePath, currentLength);

      canvas.clipRect(Rect.fromLTWH(internalPadding, height - internalPadding,
          paddedWidth, -paddedHeight));
      canvas.drawPath(extractedPath, curvePainter);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
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
