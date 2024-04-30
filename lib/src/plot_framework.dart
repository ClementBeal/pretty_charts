import 'dart:math';

import 'package:flutter/material.dart';

class PlotFrameworkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final xAxesNumberTicks = 5;
    final yAxesRange = (0, 1);
    final xAxesRange = (0, 1);

    Paint axesPainter = Paint()
      ..color = Colors.grey.shade900
      ..strokeWidth = 1.3;

    final width = size.width;
    final height = size.height;
    final aspectRatio = size.aspectRatio;

    final origin = Offset(0, height);

    const topLeftCorner = Offset.zero;
    final topRightCorner = Offset(width, 0);
    final bottomRightCorner = Offset(width, height);
    final bottomLeftCorner = Offset(0, height);

    // draw the box
    // canvas.drawLine(topLeftCorner, topRightCorner, axesPainter);
    // canvas.drawLine(topRightCorner, bottomRightCorner, axesPainter);
    canvas.drawLine(bottomRightCorner, bottomLeftCorner, axesPainter);
    canvas.drawLine(bottomLeftCorner, topLeftCorner, axesPainter);

    // draw the axes

    // canvas.drawLine(Offset(0, 20), Offset(width, 20), axesPainter);

    // draw ticks

    // actually linear

    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 22,
    );
    final tickTextPainter = TextPainter(textDirection: TextDirection.ltr);
    final xSpacing = width / xAxesNumberTicks;

    for (var i = 0; i < xAxesNumberTicks; i++) {
      canvas.drawLine(Offset(i * xSpacing, height),
          Offset(i * xSpacing, height - 8), axesPainter);
    }

    for (var i = 0; i < xAxesNumberTicks + 1; i++) {
      final caption = xAxesRange.$2 / xAxesNumberTicks * i;
      final textSpan =
          TextSpan(text: caption.toStringAsFixed(2), style: textStyle);
      tickTextPainter.text = textSpan;

      tickTextPainter.layout(maxWidth: 60);
      tickTextPainter.paint(canvas,
          Offset(xSpacing * i - tickTextPainter.width / 2, height - 40));
    }

    // draw a curve
    final curvePath = Path();
    final curvePainter = Paint()
      ..color = Colors.green.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    curvePath.moveTo(0, height);

    final curveStep = width / 300;

    for (var i = 0; i < 300; i++) {
      curvePath.lineTo(
        i * curveStep,
        height - (sin(i / 300)) * (height * yAxesRange.$2),
      );
    }

    canvas.drawPath(curvePath, curvePainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
