import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

@RoutePage()
class BasicPiePlotScreen extends StatelessWidget {
  const BasicPiePlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          width: 400,
          height: 400,
          child: PiePlot(
            colorMap: pastel1,
            config: PiePlotConfig(
              title: "Gender population",
              centeredTitle: true,
              holeRadiusRatio: 0.3,
              showLabels: true,
              drawBorders: true,
              onGenerateLabels: (value, valuePercentage, name) {
                return "$name\n(${valuePercentage.toStringAsFixed(2)}%)";
              },
            ),
            data: [
              PiePlotData(name: "Men", value: 43.45),
              PiePlotData(name: "Women", value: 56.55),
            ],
          ),
        ),
      ),
    );
  }
}
