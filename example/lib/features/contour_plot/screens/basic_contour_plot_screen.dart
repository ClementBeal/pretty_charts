import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

class BasicContourPlotScreen extends StatelessWidget {
  const BasicContourPlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          width: 700,
          height: 700,
          child: ContourPlot(
            axes: CartesianAxes(
              xLimits: AxesLimit(-3, 3),
              yLimits: AxesLimit(-2, 2),
              numberOfTicksOnX: 6,
              numberOfTicksOnY: 6,
            ),
            data: [
              ContourPlotData(
                onGenerate: (x, y) {
                  return exp(-pow((x - 1), 2) - pow((y - 1), 2));
                },
                nbLines: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
