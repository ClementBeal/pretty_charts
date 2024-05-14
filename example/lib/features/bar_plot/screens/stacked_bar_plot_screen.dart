import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

@RoutePage()
class StackedBarPlotScreen extends StatelessWidget {
  const StackedBarPlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox.expand(
          child: BarPlot(
            axes: CartesianAxes(
              xLimits: AxesLimit(0, 1),
              yLimits: AxesLimit(0, 1),
              numberOfTicksOnX: 1,
              numberOfTicksOnY: 1,
            ),
            data: [
              BarPlotData(
                x: [1, 2, 3, 4],
                y: [2, 7, 4, 5],
              ),
              BarPlotData(
                x: [1, 2, 3, 4],
                y: [8, 1, 3, 2],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
