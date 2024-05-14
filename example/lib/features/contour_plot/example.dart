import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

class ContourPlotExample extends StatelessWidget {
  const ContourPlotExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ContourPlot(
      axes: CartesianAxes(
        xLimits: AxesLimit(0, 5),
        yLimits: AxesLimit(0, 5),
        numberOfTicksOnX: 3,
        numberOfTicksOnY: 3,
      ),
      data: [
        ContourPlotData(
          onGenerate: (x, y) {
            return sin(x) + sin(y);
          },
          nbLines: 20,
        ),
      ],
    );
  }
}
