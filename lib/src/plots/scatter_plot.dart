import 'package:flutter/widgets.dart';
import 'package:pretty_charts/src/plot_framework.dart';

class ScatterPlot extends StatelessWidget {
  const ScatterPlot({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: PlotFrameworkPainter(),
      child: SizedBox(),
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
