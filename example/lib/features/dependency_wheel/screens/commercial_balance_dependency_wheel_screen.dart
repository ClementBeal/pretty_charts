import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

class AndroidIphoneDependencyWheelScreen extends StatelessWidget {
  const AndroidIphoneDependencyWheelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox.expand(
        child: DependencyWheelChart(
          sectionSpacing: 2 * math.pi / 360 * 2,
          data: [
            DependencyWheelChartData(from: "iPhone", to: "USA", value: 30.0),
            DependencyWheelChartData(from: "iPhone", to: "China", value: 25.0),
            DependencyWheelChartData(
                from: "iPhone", to: "Germany", value: 10.0),
            DependencyWheelChartData(from: "iPhone", to: "Japan", value: 15.0),
            DependencyWheelChartData(from: "iPhone", to: "UK", value: 12.0),
            DependencyWheelChartData(from: "iPhone", to: "France", value: 8.0),
            DependencyWheelChartData(from: "iPhone", to: "India", value: 20.0),
            DependencyWheelChartData(from: "iPhone", to: "Brazil", value: 18.0),
            DependencyWheelChartData(from: "Android", to: "USA", value: 40.0),
            DependencyWheelChartData(from: "Android", to: "China", value: 35.0),
            DependencyWheelChartData(
                from: "Android", to: "Germany", value: 20.0),
            DependencyWheelChartData(from: "Android", to: "Japan", value: 25.0),
            DependencyWheelChartData(from: "Android", to: "UK", value: 22.0),
            DependencyWheelChartData(
                from: "Android", to: "France", value: 18.0),
            DependencyWheelChartData(from: "Android", to: "India", value: 30.0),
            DependencyWheelChartData(
                from: "Android", to: "Brazil", value: 25.0),
          ],
        ),
      ),
    );
  }
}
