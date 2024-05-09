import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

class AnimatedLinePlotScreen extends StatelessWidget {
  const AnimatedLinePlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animated line plot"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: LinePlot(
            animationCurve: Curves.bounceInOut,
            animationDuration: const Duration(milliseconds: 3400),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
