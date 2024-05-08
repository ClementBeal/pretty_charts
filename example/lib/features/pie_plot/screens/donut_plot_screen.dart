import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

class DonutPlotScreen extends StatelessWidget {
  const DonutPlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox.expand(
        child: PiePlot(
          colorMap: pastel17,
          config: PiePlotConfig(
            holeRadiusRatio: 0.3,
            title: "Pie plot with hole",
            totalValue: 8107497555,
            showLabels: true,
            drawBorders: false,
            labelStyle: const TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
            onGenerateLabels: (value, valuePercentage, name) {
              return "$name\n${(valuePercentage * 100).toStringAsFixed(2)}%";
            },
          ),
          data: [
            PiePlotData(name: "China", value: 1397897720),
            PiePlotData(name: "India", value: 1366417754),
            PiePlotData(name: "United States", value: 330883982),
            PiePlotData(name: "Indonesia", value: 273523615),
            PiePlotData(name: "Pakistan", value: 220892331),
            PiePlotData(name: "Brazil", value: 212559417),
            PiePlotData(name: "Nigeria", value: 206139589),
            PiePlotData(name: "Bangladesh", value: 164689383),
            PiePlotData(name: "Russia", value: 145912025),
            PiePlotData(name: "Mexico", value: 128932753)
          ],
        ),
      ),
    );
  }
}
