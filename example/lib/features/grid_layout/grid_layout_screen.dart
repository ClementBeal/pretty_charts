import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

class GridLayoutScreen extends StatelessWidget {
  const GridLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridPlotLayout(
        pattern: """
AABC
AADE
AAFF
AAFF""",
        orders: "ABCDEF",
        children: [
          TreeMapChart(
            interactions: const [],
            data: [
              TreeMapChartData(
                name: "France",
                value: 44,
              ),
              TreeMapChartData(
                name: "Italy",
                value: 22,
              ),
              TreeMapChartData(
                name: "Portugal",
                value: 14,
              ),
            ],
          ),
          PiePlot(
            data: [
              PiePlotData(name: "", value: 22),
              PiePlotData(name: "", value: 22),
              PiePlotData(name: "", value: 22),
            ],
          ),
          PiePlot(
            data: [
              PiePlotData(name: "", value: 22),
              PiePlotData(name: "", value: 22),
              PiePlotData(name: "", value: 22),
            ],
          ),
          PiePlot(
            data: [
              PiePlotData(name: "", value: 22),
              PiePlotData(name: "", value: 22),
              PiePlotData(name: "", value: 22),
            ],
          ),
          PiePlot(
            data: [
              PiePlotData(name: "", value: 22),
              PiePlotData(name: "", value: 22),
              PiePlotData(name: "", value: 22),
            ],
          ),
          LinePlot(
            axes: CartesianAxes(
              xLimits: AxesLimit(0, 5),
              yLimits: AxesLimit(0, 5),
              numberOfTicksOnX: 3,
              numberOfTicksOnY: 3,
            ),
            data: [
              LinePlotData(
                onGenerateY: (x) => x,
              )
            ],
          ),
        ],
      ),
    );
  }
}
