import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

@RoutePage()
class MassiveScatterPlotScreen extends StatelessWidget {
  const MassiveScatterPlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          height: 400,
          width: 400,
          child: ScatterPlot(
            axes: CartesianAxes(
              xLimits: AxesLimit(0, 10),
              yLimits: AxesLimit(0, 10),
              numberOfTicksOnX: 5,
              numberOfTicksOnY: 5,
            ),
            data: [
              ScatterPlotData(
                x: List.generate(100000, (index) => Random().nextDouble() * 10),
                y: List.generate(100000, (index) => Random().nextDouble() * 10),
                name: "Four",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
