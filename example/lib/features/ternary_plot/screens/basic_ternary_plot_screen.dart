import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

class BasicTernaryPlotScreen extends StatelessWidget {
  const BasicTernaryPlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          width: 400,
          height: 400,
          child: TernaryPlot(
            axes: TernaryPlotAxes(
              showMajorLines: true,
              bottomAxesTitle: "",
              leftAxesTitle: "",
              rightAxesTitle: "",
            ),
            data: const [],
          ),
        ),
      ),
    );
  }
}
