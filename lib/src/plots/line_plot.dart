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
      foregroundPainter: PlotFrameworkPainter(
        axes: axes,
      ),
    );
  }
}

class ScatterPlotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
