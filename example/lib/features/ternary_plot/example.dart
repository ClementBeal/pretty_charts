import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

class TernaryPlotExample extends StatelessWidget {
  const TernaryPlotExample({super.key});

  @override
  Widget build(BuildContext context) {
    return TernaryPlot(
      colorMap: pastel2,
      data: [
        TernaryPlotData(
          name: "",
          data: [
            TernaryPosition(
              leftAxesValue: 0,
              rightAxesValue: 0,
              bottomAxesValue: 100,
            ),
            TernaryPosition(
              leftAxesValue: 30,
              rightAxesValue: 0,
              bottomAxesValue: 90,
            ),
            TernaryPosition(
              leftAxesValue: 0,
              rightAxesValue: 30,
              bottomAxesValue: 90,
            ),
          ],
        ),
        TernaryPlotData(
          name: "",
          data: [
            TernaryPosition(
              leftAxesValue: 100,
              bottomAxesValue: 0,
              rightAxesValue: 0,
            ),
            TernaryPosition(
              leftAxesValue: 80,
              bottomAxesValue: 40,
              rightAxesValue: 0,
            ),
            TernaryPosition(
              leftAxesValue: 40,
              bottomAxesValue: 40,
              rightAxesValue: 40,
            ),
          ],
        ),
      ],
      axes: TernaryPlotAxes(
        leftAxesTitle: "Water",
        rightAxesTitle: "Salt",
        bottomAxesTitle: "Sugar",
      ),
    );
  }
}
