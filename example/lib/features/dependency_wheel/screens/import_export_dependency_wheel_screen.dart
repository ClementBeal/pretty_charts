import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

@RoutePage()
class ImportExportDependencyWheelScreen extends StatelessWidget {
  const ImportExportDependencyWheelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox.expand(
        child: DependencyWheelChart(
          sectionSpacing: 2 * math.pi / 360 * 2,
          data: [
            DependencyWheelChartData(from: "France", to: "USA", value: 33),
            DependencyWheelChartData(from: "USA", to: "France", value: 42.2),
            DependencyWheelChartData(from: "France", to: "Brazil", value: 12.3),
            DependencyWheelChartData(from: "Brazil", to: "France", value: 8.9),
            DependencyWheelChartData(from: "Brazil", to: "USA", value: 6.7),
            DependencyWheelChartData(from: "USA", to: "Brazil", value: 54.4),
            // DependencyWheelChartData(from: "", to: "", value: ),
            // DependencyWheelChartData(from: "", to: "", value: ),
            // DependencyWheelChartData(from: "", to: "", value: ),
            // DependencyWheelChartData(from: "", to: "", value: ),
            // DependencyWheelChartData(from: "", to: "", value: ),
            // DependencyWheelChartData(from: "", to: "", value: ),
            // DependencyWheelChartData(from: "", to: "", value: ),
            // DependencyWheelChartData(from: "", to: "", value: ),
            // DependencyWheelChartData(from: "", to: "", value: ),
            // DependencyWheelChartData(from: "", to: "", value: ),
          ],
        ),
      ),
    );
  }
}
