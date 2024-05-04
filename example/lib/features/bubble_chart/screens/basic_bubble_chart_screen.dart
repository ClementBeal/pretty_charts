import 'package:example/features/bubble_chart/bubble_chart_screen.dart';
import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

class BasicBubbleChart extends StatelessWidget {
  const BasicBubbleChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          height: 400,
          width: 400,
          child: BubbleChart(
            axes: CartesianAxes(
              xLimits: AxesLimit(0, 10),
              yLimits: AxesLimit(0, 10),
              numberOfTicksOnX: 5,
              numberOfTicksOnY: 5,
            ),
            data: [
              BubbleChartData(
                x: [0, 1, 2, 3, 4, 5, 4, 3.4, 3.2, 2.9],
                y: [8, 2, 3.4, 3, 5.6, 8.7, 9.1, 2, 1.0, 9.3],
                z: [1, 1.2, 4, 3.2, 8, 5.4, 6.7, 6.5, 9.3, 2.2],
                name: "One",
              ),
              BubbleChartData(
                x: [0.2, 1.7, 2.8, 4.6, 5.3, 6.9, 8.4, 3.5, 9.1, 0.8],
                y: [7.3, 2.5, 4.9, 1.4, 6.7, 8.2, 9.6, 3.1, 5.8, 0.6],
                z: [2.5, 3.8, 5.1, 7.4, 4.6, 8.3, 1.9, 6.2, 9.0, 0.3],
                name: "Random",
              ),
              BubbleChartData(
                x: [1.5, 3.7, 5.8, 0.9, 2.4, 4.1, 6.3, 8.2, 9.6, 7.0],
                y: [8.6, 2.3, 4.5, 7.8, 1.2, 3.9, 5.7, 9.0, 6.4, 0.8],
                z: [4.2, 2.7, 7.1, 1.9, 5.3, 3.6, 9.2, 6.5, 8.4, 0.5],
                name: "Random Data",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
