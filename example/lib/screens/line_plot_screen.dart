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
                xLimits: (-1, 1),
                yLimits: (-1, 1),
                numberOfTicksOnX: 10,
                numberOfTicksOnY: 10,
                legend: "A great line plot",
              ),
            ),
          ),
        ),
      ),
    );
  }
}