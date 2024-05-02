import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pretty_charts/src/axes/axes.dart';
import 'package:pretty_charts/src/axes/plot_framework.dart';
import 'package:pretty_charts/src/plots/contour_plot/contour_plot_data.dart';
import 'package:pretty_charts/src/shared/chart_viewer.dart';
import 'package:pretty_charts/src/shared/color_maps/sequential_color_map.dart';

class ContourPlot extends StatefulWidget {
  const ContourPlot({
    super.key,
    required this.axes,
    required this.data,
    this.animationDuration = Durations.extralong1,
    this.animationCurve = Curves.easeInOut,
  });

  final Axes axes;
  final List<ContourPlotData> data;
  final Duration animationDuration;
  final Curve animationCurve;

  @override
  State<ContourPlot> createState() => _ContourPlotState();
}

class _ContourPlotState extends State<ContourPlot>
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
      child: ClipRect(
        child: CustomPaint(
          painter: ContourPlotPainter(
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

class ContourPlotPainter extends CustomPainter {
  ContourPlotPainter({
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
  final List<ContourPlotData> data;

  /// progress value of the animation
  /// 0 is the start || 1 is the end
  /// interval of value : [0, 1]
  final double animationProgress;

  @override
  void paint(Canvas canvas, Size size) {
    const double internalPadding = 50.0;
    const double axesPadding = 20.0;
    const int points = 200;
    final colorMap = whiteBlueSquential;

    final xAxesNumberTicks = axes.numberOfTicksOnX;
    final yAxesNumberTicks = axes.numberOfTicksOnY;
    final xAxesRange = axes.xLimits.translate(offset.dx).scale(scaleFactor);
    final yAxesRange = axes.yLimits.translate(-offset.dy).scale(scaleFactor);

    final height = size.height;
    final width = size.width;

    final paddedWidth = size.width - 2 * internalPadding;
    final paddedHeight = size.height - 2 * internalPadding;

    final paddedTopLeftCorner = Offset(internalPadding, internalPadding);

    final axesOrigin = Offset(
      internalPadding + axesPadding,
      size.height - internalPadding - axesPadding,
    );

    final axesWidth = paddedWidth - 2 * axesPadding;
    final axesHeight = paddedHeight - 2 * axesPadding;

    // draw a curve
    for (var d in data) {
      final contourPainter = Paint()
        ..color = Colors.green
        ..strokeWidth = 1.2;

      final xSpacing = xAxesRange.getDiff() / points;
      final ySpacing = xAxesRange.getDiff() / points;

      final values = Float64List(points * points);
      double minValue = double.infinity;
      double maxValue = double.minPositive;

      var iYSpacing = 0.0;
      var iPoints = 0;
      for (var i = 0; i < points; i++) {
        var jXSpacing = 0.0;
        for (var j = 0; j < points; j++) {
          final x = xAxesRange.minLimit + jXSpacing;
          final y = yAxesRange.minLimit + iYSpacing;

          final value = d.onGenerate(x, y);
          minValue = min(minValue, value);
          maxValue = max(maxValue, value);
          values[j + iPoints] = value;

          jXSpacing += xSpacing;
        }
        iYSpacing += ySpacing;
        iPoints += points;
      }

      for (var i = 0; i < d.nbLines; i++) {
        final isoValue = (maxValue - minValue) / d.nbLines * i;
        contourPainter.color = blueGreenRedSquential
            .getColor((isoValue + minValue) / (maxValue + minValue));

        final binaryImage = Uint8List(values.length);

        for (var i = 0; i < values.length; i++) {
          final a = values[i];
          if (a > isoValue) {
            binaryImage[i] = 1;
          } else {
            binaryImage[i] = 0;
          }
        }

        const lim = points - 1;
        final contouringGrid = Uint8List(lim * lim);
        final widthCell = paddedWidth / points;
        final heightCell = paddedHeight / points;

        final halfWidthCell = widthCell / 2;
        final halfHeightCell = heightCell / 2;

        for (var i = 0; i < lim * lim; i++) {
          final firstIndex = i + i ~/ lim;
          final topLeftCorner = binaryImage[firstIndex];
          final topRightCorner = binaryImage[firstIndex + 1];
          final bottomRightCorner = binaryImage[firstIndex + points + 1];
          final bottomLeftCorner = binaryImage[firstIndex + points];

          final a = topLeftCorner << 3 |
              topRightCorner << 2 |
              bottomRightCorner << 1 |
              bottomLeftCorner;
          contouringGrid[i] = a;
        }

        // draw the contour
        for (var i = 0; i < contouringGrid.length; i++) {
          final x = i % lim;
          final y = i ~/ lim;

          final v = contouringGrid[i];
          final o = paddedTopLeftCorner.translate(
              widthCell * (x + 0.5), (heightCell * (0.5 + y)));

          switch (v) {
            case 0:
            case 15:
              break;
            case 1:
            case 14:
              canvas.drawLine(
                o.translate(0, halfHeightCell),
                o.translate(halfWidthCell, heightCell),
                contourPainter,
              );
              break;
            case 2:
            case 13:
              canvas.drawLine(
                o.translate(halfWidthCell, heightCell),
                o.translate(widthCell, halfHeightCell),
                contourPainter,
              );
              break;
            case 3:
            case 12:
              canvas.drawLine(
                o.translate(0, halfHeightCell),
                o.translate(widthCell, halfHeightCell),
                contourPainter,
              );
              break;
            case 4:
            case 11:
              canvas.drawLine(
                o.translate(halfWidthCell, 0),
                o.translate(widthCell, halfHeightCell),
                contourPainter,
              );
              break;
            case 5:
              canvas.drawLine(
                o.translate(0, halfHeightCell),
                o.translate(halfWidthCell, 0),
                contourPainter,
              );
              canvas.drawLine(
                o.translate(halfWidthCell, heightCell),
                o.translate(widthCell, halfHeightCell),
                contourPainter,
              );
              break;
            case 6:
            case 9:
              canvas.drawLine(
                o.translate(halfWidthCell, 0),
                o.translate(halfWidthCell, heightCell),
                contourPainter,
              );
              break;
            case 7:
            case 8:
              canvas.drawLine(
                o.translate(0, halfHeightCell),
                o.translate(halfWidthCell, 0),
                contourPainter,
              );
              break;
            case 10:
              canvas.drawLine(
                o.translate(0, halfHeightCell),
                o.translate(halfWidthCell, heightCell),
                contourPainter,
              );
              canvas.drawLine(
                o.translate(halfWidthCell, 0),
                o.translate(widthCell, halfHeightCell),
                contourPainter,
              );
              break;
            default:
              break;
          }
        }
      }

      drawColorMap(canvas, Offset(width - 30, internalPadding), paddedHeight,
          minValue, maxValue, blueGreenRedSquential);
    }
  }

  void drawColorMap(
    Canvas canvas,
    Offset colorMapOrigin,
    double height,
    double minValue,
    double maxValue,
    ColorMap colorMap,
  ) {
    const rectangleWidth = 30 / 2;
    final painter = Paint()
      ..shader = ui.Gradient.linear(
        Offset(rectangleWidth, height),
        Offset(rectangleWidth, 0),
        colorMap.colors,
        List.generate(
            colorMap.colors.length, (i) => i * (1 / colorMap.colors.length)),
      );

    canvas.drawRect(
        Rect.fromLTWH(colorMapOrigin.dx, colorMapOrigin.dy, 30, height),
        painter);
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
