import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

class MultipleLinePlotsScreen extends StatelessWidget {
  const MultipleLinePlotsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Multiple line plots"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: LinePlot(
            animationDuration: const Duration(milliseconds: 1250),
            axes: CartesianAxes(
              xLimits: AxesLimit(-1, 1),
              yLimits: AxesLimit(-1, 1),
              numberOfTicksOnX: 5,
              numberOfTicksOnY: 5,
              showGrid: true,
              title: "A great line plot",
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
              ),
              LinePlotData(
                onGenerateY: (x) {
                  return pow(x, 2).toDouble();
                },
              ),
              LinePlotData(
                onGenerateY: (x) {
                  return pow(x, 1).toDouble();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
