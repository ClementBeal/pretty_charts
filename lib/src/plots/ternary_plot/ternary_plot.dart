import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pretty_charts/src/plots/line_plot/line_plot.dart';
import 'package:pretty_charts/src/plots/ternary_plot/ternary_plot_data.dart';
import 'package:pretty_charts/src/shared/chart_viewer.dart';
import 'package:pretty_charts/src/shared/color_maps/color_map.dart';
import 'package:pretty_charts/src/shared/color_maps/qualitative_color_map.dart';
import 'package:pretty_charts/src/shared/polygon_centroid.dart';

class TernaryPlot extends StatefulWidget {
  const TernaryPlot({
    super.key,
    required this.data,
    required this.axes,
    this.colorMap,
  });

  final TernaryPlotAxes axes;
  final List<TernaryPlotData> data;
  final ColorMap? colorMap;

  @override
  State<TernaryPlot> createState() => _TernaryPlotState();
}

class _TernaryPlotState extends State<TernaryPlot> {
  double _scaleFactor = 1.0;
  Offset _offset = Offset.zero;

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
            painter: TernaryPlotPainter(
              scaleFactor: _scaleFactor,
              axes: widget.axes,
              offset: _offset,
              data: widget.data,
              colorMap: widget.colorMap ?? pastel1,
            ),
          ),
        ),
      ),
    );
  }
}

class TernaryPlotPainter extends CustomPainter {
  TernaryPlotPainter({
    super.repaint,
    required this.axes,
    required this.scaleFactor,
    required this.offset,
    required this.data,
    required this.colorMap,
  }) {
    trianglePainter = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    majorLinePainter = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
  }

  final TernaryPlotAxes axes;
  final double scaleFactor;
  final Offset offset;
  final List<TernaryPlotData> data;
  final ColorMap colorMap;

  late Paint trianglePainter;
  late Paint majorLinePainter;

  @override
  void paint(Canvas canvas, Size size) {
    colorMap.reset();
    const double internalPadding = 0.0;
    final dimension = size.shortestSide;

    final paddedWidth = dimension - 2 * internalPadding;
    final paddedHeight = dimension - 2 * internalPadding;

    final axesWidth = paddedWidth;
    final axesHeight = paddedHeight;

    final triangleSize = sqrt(3) / 2;

    final axesOrigin = Offset(
      (size.width - dimension) / 2,
      triangleSize * size.height - (triangleSize * size.height - dimension) / 2,
    );

    final trianglePath = Path();
    trianglePath.moveTo(axesOrigin.dx, axesOrigin.dy);
    trianglePath.relativeLineTo(axesWidth, 0);
    trianglePath.relativeLineTo(-axesWidth / 2, -axesHeight * triangleSize);
    trianglePath.close();

    canvas.drawPath(trianglePath, trianglePainter);

    if (axes.showMajorLines) {
      final majorLinesPath = Path();

      final triangleWith = axesWidth / 10;
      final triangleHeight = sqrt(3) / 2 * axesHeight / 10;

      for (var i = 0; i < 9; i++) {
        // horizontal lines;
        majorLinesPath.moveTo(axesOrigin.dx + triangleWith / 2 * (i + 1),
            axesOrigin.dy - (1 + i) * triangleHeight);
        majorLinesPath.relativeLineTo(axesWidth - triangleWith * (1 + i), 0);

        // top left -> bottom right
        majorLinesPath.moveTo(axesOrigin.dx + triangleWith / 2 * (i + 1),
            axesOrigin.dy - (1 + i) * triangleHeight);
        majorLinesPath.relativeLineTo(
            triangleWith / 2 * (1 + i), triangleHeight * (1 + i));

        // top right -> bottom left
        majorLinesPath.moveTo(
          axesOrigin.dx + triangleWith * (1 + i),
          axesOrigin.dy,
        );
        majorLinesPath.relativeLineTo(
          axesWidth / 2 - triangleWith * (1 + i) / 2,
          -sqrt(3) / 2 * axesHeight + triangleHeight * (1 + i),
        );
      }

      canvas.drawPath(useDashedLine(majorLinesPath, 6, 3), majorLinePainter);

      drawAxesLabels(canvas, dimension, axesOrigin);

      final blockPainter = Paint()..style = PaintingStyle.fill;
      final blockBorderPainter = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      final blockTextPainter = TextPainter(textDirection: TextDirection.ltr);
      final textStyle = TextStyle(
        color: Colors.grey.shade800,
        fontSize: 12,
      );

      for (var (i, d) in data.indexed) {
        final blockPath = Path();
        final cartesianPositions = <Offset>[];

        for (var position in d.data) {
          cartesianPositions.add(position.toCartesian);
        }

        // final textCenter = ;

        blockTextPainter.text = TextSpan(text: d.name, style: textStyle);
        blockTextPainter.layout();

        blockPath.moveTo(
          axesOrigin.dx + cartesianPositions.first.dx * axesWidth,
          axesOrigin.dy - cartesianPositions.first.dy * axesHeight,
        );

        for (var e in cartesianPositions) {
          blockPath.lineTo(
            axesOrigin.dx + e.dx * axesWidth,
            axesOrigin.dy - e.dy * axesHeight,
          );
        }

        blockPath.close();
        blockPainter.color =
            colorMap.getColor(i / data.length).withOpacity(0.3);
        canvas.drawPath(blockPath, blockPainter);
        canvas.drawPath(blockPath, blockBorderPainter);

        final centroid = getPolygonCentroid(cartesianPositions);

        blockTextPainter.paint(
          canvas,
          Offset(
            axesOrigin.dx +
                centroid.dx * axesWidth -
                blockTextPainter.width / 2,
            axesOrigin.dy -
                centroid.dy * axesHeight -
                blockTextPainter.height / 2,
          ),
        );
      }
    }
  }

  void drawAxesLabels(Canvas canvas, double dimension, Offset axesOrigin) {
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final textStyle = TextStyle(
      color: Colors.grey.shade400,
      fontSize: 22,
    );

    final bottomLabelText = TextSpan(
      text: axes.bottomAxesTitle,
      style: textStyle,
    );

    // bottom label
    textPainter.text = bottomLabelText;
    textPainter.layout();
    textPainter.paint(
      canvas,
      axesOrigin.translate(
        dimension / 2 - textPainter.width / 2,
        textPainter.height / 2,
      ),
    );

    // left label
    final leftLabelText = TextSpan(
      text: axes.leftAxesTitle,
      style: textStyle,
    );
    textPainter.text = leftLabelText;
    textPainter.layout();
    textPainter.paint(
      canvas,
      axesOrigin.translate(
        dimension / 4 - textPainter.width / 2,
        -dimension / 2 - textPainter.height / 2,
      ),
    );

    // right label
    final rightLabelText = TextSpan(
      text: axes.rightAxesTitle,
      style: textStyle,
    );
    textPainter.text = rightLabelText;
    textPainter.layout();
    textPainter.paint(
      canvas,
      axesOrigin.translate(
        dimension * 3 / 4 - textPainter.width / 2,
        -dimension / 2 - textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
