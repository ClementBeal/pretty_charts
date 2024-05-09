import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

class DashedPointedLinePlotScreen extends StatelessWidget {
  const DashedPointedLinePlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashed & Pointed line plot"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: LinePlot(
            axes: CartesianAxes(
              xLimits: AxesLimit(-1, 1),
              yLimits: AxesLimit(-1, 1),
              numberOfTicksOnX: 5,
              numberOfTicksOnY: 5,
              showGrid: true,
              bordersToDisplay: [AxesBorder.left, AxesBorder.bottom],
              arrowsToDisplay: [AxesBorder.top, AxesBorder.right],
              xLabelsBuilder: (x) {
                return x.toStringAsFixed(2);
              },
              yLabelsBuilder: (x) {
                return x.toStringAsFixed(3);
              },
            ),
            data: [
              LinePlotData(
                onGenerateY: (x) {
                  return pow(x, 3).toDouble();
                },
                lineStyle: LineStyle.dashed,
              ),
              LinePlotData(
                onGenerateY: (x) {
                  return pow(x, 2).toDouble();
                },
                lineStyle: LineStyle.point,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
