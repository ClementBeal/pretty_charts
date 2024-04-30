import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

class LinePlotScreen extends StatelessWidget {
  const LinePlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Line plot"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SizedBox(
            width: 400,
            height: 400,
            child: LinePlot(
              axes: Axes(
                xLimits: (-12, 12),
                yLimits: (-30, 100),
                // yLimits: (-1, 4),
                numberOfTicksOnX: 5,
                numberOfTicksOnY: 5,
                showGrid: true,
                legend: "A great line plot",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
