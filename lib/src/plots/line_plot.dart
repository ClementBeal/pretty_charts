import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pretty_charts/src/axes/axes.dart';
import 'package:pretty_charts/src/axes/plot_framework.dart';

class LinePlot extends StatelessWidget {
  const LinePlot({
    super.key,
    required this.axes,
  });

  final Axes axes;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LinePlotPainter(
        axes: axes,
      ),
      foregroundPainter: PlotFrameworkPainter(
        axes: axes,
      ),
    );
  }
}

class LinePlotPainter extends CustomPainter {
  LinePlotPainter({super.repaint, required this.axes});

  final Axes axes;

  @override
  void paint(Canvas canvas, Size size) {
    const double internalPadding = 50.0;
    const double axesPadding = 20.0;
    const int points = 10;

    final xAxesNumberTicks = axes.numberOfTicksOnX;
    final yAxesNumberTicks = axes.numberOfTicksOnY;
    final yAxesRange = axes.xLimits;
    final xAxesRange = axes.yLimits;

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
    final curvePath = Path();
    final curvePainter = Paint()
      ..color = Colors.green.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    // canvas.drawCircle(axesOrigin, 30, curvePainter);

    curvePath.moveTo(axesOrigin.dx, axesOrigin.dy);

    final curveStep = axesWidth / points;

    for (var i = 0; i < points + 1; i++) {
      final computedValue = (pow((i / points), 2));

      curvePath.lineTo(
        axesOrigin.dx + i * curveStep,
        axesOrigin.dy - computedValue * (axesHeight * yAxesRange.$2),
      );
    }

    canvas.drawPath(curvePath, curvePainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
