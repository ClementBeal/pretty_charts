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
            DependencyWheelChartData(
                from: "France", to: "Germany", value: 23.1),
            DependencyWheelChartData(
                from: "Germany", to: "France", value: 18.5),
            DependencyWheelChartData(from: "Germany", to: "USA", value: 9.8),
            DependencyWheelChartData(from: "USA", to: "Germany", value: 12.7),
            DependencyWheelChartData(from: "Germany", to: "Brazil", value: 7.2),
            DependencyWheelChartData(from: "Brazil", to: "Germany", value: 5.6),
            DependencyWheelChartData(from: "Japan", to: "France", value: 15.4),
            DependencyWheelChartData(from: "France", to: "Japan", value: 10.9),
            DependencyWheelChartData(from: "Japan", to: "USA", value: 8.7),
            DependencyWheelChartData(from: "USA", to: "Japan", value: 9.1),
            DependencyWheelChartData(from: "Japan", to: "Brazil", value: 6.3),
            DependencyWheelChartData(from: "Brazil", to: "Japan", value: 4.8),
            DependencyWheelChartData(from: "China", to: "France", value: 18.7),
            DependencyWheelChartData(from: "France", to: "China", value: 22.3),
            DependencyWheelChartData(from: "China", to: "USA", value: 9.2),
            DependencyWheelChartData(from: "USA", to: "China", value: 13.5),
            DependencyWheelChartData(from: "China", to: "Brazil", value: 5.6),
            DependencyWheelChartData(from: "Brazil", to: "China", value: 4.1),
            DependencyWheelChartData(from: "India", to: "Germany", value: 4.7),
            DependencyWheelChartData(from: "Germany", to: "India", value: 3.2),
            DependencyWheelChartData(from: "India", to: "Japan", value: 5.1),
            DependencyWheelChartData(from: "Japan", to: "India", value: 4.3),
            DependencyWheelChartData(from: "India", to: "China", value: 7.2),
            DependencyWheelChartData(from: "China", to: "India", value: 5.8),
            DependencyWheelChartData(from: "India", to: "Russia", value: 3.5),
            DependencyWheelChartData(from: "Russia", to: "India", value: 2.9),
            DependencyWheelChartData(from: "Germany", to: "Japan", value: 6.7),
            DependencyWheelChartData(from: "Japan", to: "Germany", value: 5.5),
            DependencyWheelChartData(from: "Germany", to: "China", value: 9.1),
            DependencyWheelChartData(from: "China", to: "Germany", value: 7.6),
            DependencyWheelChartData(from: "Germany", to: "Russia", value: 4.3),
            DependencyWheelChartData(from: "Russia", to: "Germany", value: 3.6),
            DependencyWheelChartData(from: "Japan", to: "China", value: 6.3),
            DependencyWheelChartData(from: "China", to: "Japan", value: 5.2),
            DependencyWheelChartData(from: "Japan", to: "Russia", value: 3.9),
            DependencyWheelChartData(from: "Russia", to: "Japan", value: 3.2),
            DependencyWheelChartData(from: "China", to: "Russia", value: 4.7),
            DependencyWheelChartData(from: "Russia", to: "China", value: 3.9),
            DependencyWheelChartData(from: "USA", to: "India", value: 7.5),
            DependencyWheelChartData(from: "India", to: "USA", value: 9.8),
            DependencyWheelChartData(from: "USA", to: "Germany", value: 11.3),
            DependencyWheelChartData(from: "Germany", to: "USA", value: 8.7),
            DependencyWheelChartData(from: "USA", to: "Japan", value: 10.2),
            DependencyWheelChartData(from: "Japan", to: "USA", value: 7.4),
            DependencyWheelChartData(from: "USA", to: "China", value: 12.6),
            DependencyWheelChartData(from: "China", to: "USA", value: 9.1),
            DependencyWheelChartData(from: "USA", to: "Russia", value: 8.3),
            DependencyWheelChartData(from: "Russia", to: "USA", value: 6.9),
            DependencyWheelChartData(from: "India", to: "France", value: 9.7),
            DependencyWheelChartData(from: "France", to: "India", value: 7.4),
            DependencyWheelChartData(from: "India", to: "Germany", value: 5.8),
            DependencyWheelChartData(from: "Germany", to: "India", value: 4.6),
            DependencyWheelChartData(from: "India", to: "Japan", value: 6.2),
          ],
        ),
      ),
    );
  }
}
