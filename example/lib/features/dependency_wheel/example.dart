import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

class DependencyWheelExample extends StatelessWidget {
  const DependencyWheelExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DependencyWheelChart(
      sectionSpacing: 0.2,
      data: [
        DependencyWheelChartData(from: "A", to: "B", value: 2),
        DependencyWheelChartData(from: "A", to: "C", value: 1),
        DependencyWheelChartData(from: "C", to: "B", value: 4),
      ],
    );
  }
}
