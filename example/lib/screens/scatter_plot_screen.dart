import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

class ScatterPlotScreen extends StatelessWidget {
  const ScatterPlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scatter plot"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SizedBox(
            width: 400,
            height: 400,
            child: ScatterPlot(),
          ),
        ),
      ),
    );
  }
}
