import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

class TreemapChartExample extends StatelessWidget {
  const TreemapChartExample({super.key});

  @override
  Widget build(BuildContext context) {
    return TreeMapChart(
      data: [
        TreeMapChartData(name: "France", value: 54),
        TreeMapChartData(name: "Italy", value: 22),
        TreeMapChartData(name: "Spain", value: 10),
        TreeMapChartData(name: "Portugal", value: 5),
        TreeMapChartData(name: "UK", value: 2),
      ],
    );
  }
}
