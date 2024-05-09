import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

class BubbleChartExample extends StatelessWidget {
  const BubbleChartExample({super.key});

  @override
  Widget build(BuildContext context) {
    return BubbleChart(
      colorMap: pastel2,
      data: [
        BubbleChartData(
          x: [0, 1, 2, 3, 4, 5],
          y: [3, 2, 5, 4, 4.3, 2.3],
          z: [4, 3, 8, 1, 9, 2],
          name: "",
        ),
        BubbleChartData(
          x: [2.2, 3.3, 4.4, 0.3, 2.9, 4],
          y: [0.5, 0.7, 2.9, 3.9, 4.4, 1.1],
          z: [3, 3, 3, 2.8, 1.2, 5.4],
          name: "",
        ),
      ],
      axes: CartesianAxes(
        xLimits: AxesLimit(0, 5),
        yLimits: AxesLimit(0, 5),
        numberOfTicksOnX: 3,
        numberOfTicksOnY: 3,
        showGrid: true,
      ),
    );
  }
}
