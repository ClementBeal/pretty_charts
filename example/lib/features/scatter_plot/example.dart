import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

class ScatterPlotExample extends StatelessWidget {
  const ScatterPlotExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ScatterPlot(
      data: [
        ScatterPlotData(
          x: [0, 1, 2, 3, 4, 5, 4, 3],
          y: [0, 1, 2, 3, 4, 5, 3, 1],
          name: "",
        ),
        ScatterPlotData(
          x: [0, 1, 2, 3, 4],
          y: [3, 4, 1, 1.2, 5],
          name: "",
        )
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
