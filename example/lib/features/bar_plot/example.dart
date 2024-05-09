import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

class BarPlotExample extends StatelessWidget {
  const BarPlotExample({super.key});

  @override
  Widget build(BuildContext context) {
    return BarPlot(
      axes: CartesianAxes(
        showGrid: true,
        xLimits: AxesLimit(0, 5),
        yLimits: AxesLimit(0, 5),
        numberOfTicksOnX: 3,
        numberOfTicksOnY: 3,
        bordersToDisplay: [AxesBorder.left, AxesBorder.bottom],
      ),
      data: [
        BarPlotData(
          x: [0, 1, 2],
          y: [3, 4, 1],
        ),
      ],
    );
  }
}
