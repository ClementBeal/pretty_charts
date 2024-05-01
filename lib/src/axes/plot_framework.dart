import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';
import 'package:pretty_charts/src/axes/axes.dart';
import 'package:pretty_charts/src/plots/line_plot/line_plot_data.dart';

class PlotFrameworkPainter extends CustomPainter {
  PlotFrameworkPainter({
    super.repaint,
    required this.axes,
    required this.scaleFactor,
    required this.offset,
  });

  final Axes axes;
  final double scaleFactor;
  final Offset offset;

  @override
  void paint(Canvas canvas, Size size) {
    const double internalPadding = 50.0;
    const double axesPadding = 20.0;

    final xAxesNumberTicks = axes.numberOfTicksOnX;
    final yAxesNumberTicks = axes.numberOfTicksOnY;
    final xAxesRange = axes.xLimits.translate(offset.dx).scale(scaleFactor);
    final yAxesRange = axes.yLimits.translate(-offset.dy).scale(scaleFactor);

    Paint axesPainter = Paint()
      ..color = Colors.grey.shade900
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3;
    Paint arrowsPainter = Paint()
      ..color = Colors.grey.shade900
      ..style = PaintingStyle.fill;

    final gridPainter = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    canvas.drawRect(
        Rect.fromLTWH(1, 1, size.width - 1, size.height - 1), axesPainter);

    final height = size.height;
    final width = size.width;

    final paddedWidth = size.width - 2 * internalPadding;
    final paddedHeight = size.height - 2 * internalPadding;

    const topLeftCorner = Offset(internalPadding, internalPadding);
    final topRightCorner = topLeftCorner.translate(paddedWidth, 0);
    final bottomRightCorner = topRightCorner.translate(0, paddedHeight);
    final bottomLeftCorner = bottomRightCorner.translate(-paddedWidth, 0);

    final axesOrigin = bottomLeftCorner.translate(axesPadding, -axesPadding);

    final axesWidth = paddedWidth - 2 * axesPadding;
    final axesHeight = paddedHeight - 2 * axesPadding;

    // draw the box
    if (axes.bordersToDisplay.contains(AxesBorder.top)) {
      canvas.drawLine(topLeftCorner, topRightCorner, axesPainter);
    }
    if (axes.bordersToDisplay.contains(AxesBorder.right)) {
      canvas.drawLine(topRightCorner, bottomRightCorner, axesPainter);
    }
    if (axes.bordersToDisplay.contains(AxesBorder.bottom)) {
      canvas.drawLine(bottomRightCorner, bottomLeftCorner, axesPainter);
    }
    if (axes.bordersToDisplay.contains(AxesBorder.left)) {
      canvas.drawLine(bottomLeftCorner, topLeftCorner, axesPainter);
    }

    // draw the arrows

    if (axes.arrowsToDisplay.contains(AxesBorder.top)) {
      final leftArrowPath = Path()
        ..moveTo(0, 10)
        ..relativeLineTo(5, -10)
        ..relativeLineTo(5, 10)
        ..close();
      canvas.drawPath(
        leftArrowPath.shift(
          Offset(
            internalPadding - leftArrowPath.getBounds().width / 2,
            internalPadding,
          ),
        ),
        arrowsPainter,
      );
    }
    if (axes.arrowsToDisplay.contains(AxesBorder.right)) {
      final rightArrowPath = Path()
        ..moveTo(0, 0)
        ..relativeLineTo(10, 5)
        ..relativeLineTo(-10, 5)
        ..close();
      canvas.drawPath(
        rightArrowPath.shift(
          Offset(
            internalPadding + paddedWidth,
            internalPadding +
                paddedHeight -
                rightArrowPath.getBounds().height / 2,
          ),
        ),
        arrowsPainter,
      );
    }
    // if (axes.arrowsToDisplay.contains(AxesBorder.bottom)) {
    //   canvas.drawLine(bottomRightCorner, bottomLeftCorner, axesPainter);
    // }
    // if (axes.arrowsToDisplay.contains(AxesBorder.left)) {
    //   canvas.drawLine(bottomLeftCorner, topLeftCorner, axesPainter);
    // }

    // draw ticks

    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 12,
    );
    final tickTextPainter = TextPainter(textDirection: TextDirection.ltr);
    final xSpacing = (paddedWidth - 2 * axesPadding) / xAxesNumberTicks;
    final ySpacing = (paddedWidth - 2 * axesPadding) / yAxesNumberTicks;

    for (var i = 0; i < xAxesNumberTicks + 1; i++) {
      final tickPosition = Offset(axesPadding + i * xSpacing, 0);
      canvas.drawLine(
        bottomLeftCorner.translate(tickPosition.dx, tickPosition.dy),
        bottomLeftCorner.translate(axesPadding + i * xSpacing, -8),
        axesPainter,
      );

      if (axes.showGrid) {
        canvas.drawLine(
          axesOrigin.translate(i * xSpacing, axesPadding),
          axesOrigin.translate(i * xSpacing, -axesHeight - axesPadding),
          gridPainter,
        );
      }
    }

    for (var i = 0; i < xAxesNumberTicks + 1; i++) {
      final caption = xAxesRange.minLimit +
          (xAxesRange.maxLimit - xAxesRange.minLimit) / xAxesNumberTicks * i;
      final textSpan = TextSpan(
        text: axes.xLabelsBuilder?.call(caption) ?? caption.toStringAsFixed(1),
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

      if (axes.showGrid) {
        // horizontal grid lines
        canvas.drawLine(
          axesOrigin.translate(-axesPadding, -i * ySpacing),
          axesOrigin.translate(axesWidth + axesPadding, -i * ySpacing),
          gridPainter,
        );
      }
    }

    for (var i = 0; i < xAxesNumberTicks + 1; i++) {
      final caption =
          yAxesRange.minLimit + yAxesRange.getDiff() / yAxesNumberTicks * i;
      final textSpan = TextSpan(
        text: axes.yLabelsBuilder?.call(caption) ?? caption.toStringAsFixed(1),
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

    if (axes.title != null) {
      drawLegend(canvas, width, height);
    }
  }

  void drawLegend(Canvas canvas, double width, double height) {
    var textStyle = const TextStyle(
      color: Colors.black,
      fontSize: 20,
    );
    final legendPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: axes.title!,
        style: textStyle,
      ),
    );

    legendPainter.layout();

    legendPainter.paint(
      canvas,
      Offset(
        width / 2 - legendPainter.width / 2,
        0,
      ),
    );

    if (axes.xTitle != null) {
      legendPainter.text = TextSpan(
        text: axes.xTitle,
        style: textStyle,
      );

      legendPainter.layout();
      legendPainter.paint(
        canvas,
        Offset(
          width / 2 - legendPainter.width / 2,
          height - legendPainter.height * 1.5,
        ),
      );
    }

    if (axes.yTitle != null) {
      legendPainter.text = TextSpan(
        text: axes.yTitle,
        style: textStyle,
      );
      legendPainter.layout();

      final textPosition = Offset(0, height / 2);

      canvas.save();
      canvas.translate(textPosition.dx, textPosition.dy);
      canvas.rotate(-pi / 2);
      canvas.translate(-textPosition.dx, -textPosition.dy);

      legendPainter.paint(
        canvas,
        Offset(
          textPosition.dx - legendPainter.width / 2,
          textPosition.dy,
        ),
      );

      canvas.restore();
    }
  }

  void drawVerticalAxes() {}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
