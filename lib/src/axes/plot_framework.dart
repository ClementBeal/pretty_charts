import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

class PlotFrameworkPainter extends CustomPainter {
  PlotFrameworkPainter({super.repaint, required this.axes});

  final Axes axes;

  // Offset convertPoint(double x, double y, )

  @override
  void paint(Canvas canvas, Size size) {
    const double internalPadding = 50.0;
    const double axesPadding = 20.0;

    final xAxesNumberTicks = axes.numberOfTicksOnX;
    final yAxesNumberTicks = axes.numberOfTicksOnY;
    final yAxesRange = axes.xLimits;
    final xAxesRange = axes.yLimits;

    Paint axesPainter = Paint()
      ..color = Colors.grey.shade900
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3;

    canvas.drawRect(
        Rect.fromLTWH(1, 1, size.width - 1, size.height - 1), axesPainter);

    final height = size.height;
    final width = size.width;

    final paddedWidth = size.width - 2 * internalPadding;
    final paddedHeight = size.height - 2 * internalPadding;

    final topLeftCorner = Offset(internalPadding, internalPadding);
    final topRightCorner = topLeftCorner.translate(paddedWidth, 0);
    final bottomRightCorner = topRightCorner.translate(0, paddedHeight);
    final bottomLeftCorner = bottomRightCorner.translate(-paddedWidth, 0);

    final axesOrigin = bottomLeftCorner.translate(axesPadding, -axesPadding);

    // draw the box
    canvas.drawLine(topLeftCorner, topRightCorner, axesPainter);
    canvas.drawLine(topRightCorner, bottomRightCorner, axesPainter);
    canvas.drawLine(bottomRightCorner, bottomLeftCorner, axesPainter);
    canvas.drawLine(bottomLeftCorner, topLeftCorner, axesPainter);

    // draw the axes

    // x axes
    // canvas.drawLine(
    //   topLeftCorner.translate(
    //     0,
    //     paddedHeight / 2,
    //   ),
    //   topLeftCorner.translate(
    //     paddedWidth,
    //     paddedHeight / 2,
    //   ),
    //   axesPainter,
    // );

    // // y axes
    // canvas.drawLine(
    //   topLeftCorner.translate(
    //     paddedWidth / 2,
    //     0,
    //   ),
    //   topLeftCorner.translate(
    //     paddedWidth / 2,
    //     paddedHeight,
    //   ),
    //   axesPainter,
    // );

    // draw ticks

    // actually linear

    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 12,
    );
    final tickTextPainter = TextPainter(textDirection: TextDirection.ltr);
    final xSpacing = (paddedWidth - 2 * axesPadding) / xAxesNumberTicks;
    final ySpacing = (paddedWidth - 2 * axesPadding) / yAxesNumberTicks;

    for (var i = 0; i < xAxesNumberTicks + 1; i++) {
      canvas.drawLine(
        bottomLeftCorner.translate(axesPadding + i * xSpacing, 0),
        bottomLeftCorner.translate(axesPadding + i * xSpacing, -8),
        axesPainter,
      );
    }

    for (var i = 0; i < xAxesNumberTicks + 1; i++) {
      final caption = xAxesRange.$2 / xAxesNumberTicks * i;
      final textSpan = TextSpan(
        text: caption.toStringAsFixed(1),
        style: textStyle,
      );
      tickTextPainter.text = textSpan;

      tickTextPainter.layout(maxWidth: 60);
      tickTextPainter.paint(
        canvas,
        bottomLeftCorner.translate(
            axesPadding + xSpacing * i - tickTextPainter.width / 2, 4),
      );
    }

    // draw Y axes
    for (var i = 0; i < yAxesNumberTicks + 1; i++) {
      canvas.drawLine(
        bottomLeftCorner.translate(0, -axesPadding - i * ySpacing),
        bottomLeftCorner.translate(8, -axesPadding - i * ySpacing),
        axesPainter,
      );
    }

    for (var i = 0; i < xAxesNumberTicks + 1; i++) {
      final caption = xAxesRange.$2 / xAxesNumberTicks * i;
      final textSpan = TextSpan(
        text: caption.toStringAsFixed(1),
        style: textStyle,
      );
      tickTextPainter.text = textSpan;

      tickTextPainter.layout(maxWidth: 60);
      tickTextPainter.paint(
        canvas,
        bottomLeftCorner.translate(
          -tickTextPainter.width - 8,
          -axesPadding - ySpacing * i - tickTextPainter.height / 2,
        ),
      );
    }

    // draw a curve
    // final curvePath = Path();
    // final curvePainter = Paint()
    //   ..color = Colors.green.shade400
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 3;
    // curvePath.moveTo(0, height);

    // final curveStep = width / 300;

    // for (var i = 0; i < 300; i++) {
    //   curvePath.lineTo(
    //     i * curveStep,
    //     height - (sin(i / 300)) * (height * yAxesRange.$2),
    //   );
    // }

    // canvas.drawPath(curvePath, curvePainter);
    // if (axes.legend != null) {
    //   final legendPainter = TextPainter(
    //     textDirection: TextDirection.ltr,
    //     text: TextSpan(
    //       text: axes.legend!,
    //       style: TextStyle(
    //         color: Colors.black,
    //         fontStyle: FontStyle.italic,
    //         fontSize: 20,
    //       ),
    //     ),
    //   );

    //   legendPainter.layout();

    //   legendPainter.paint(
    //     canvas,
    //     Offset(
    //       width / 2 - legendPainter.width / 2,
    //       height - legendPainter.height,
    //     ),
    //   );
    // }
  }

  void drawVerticalAxes() {}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
