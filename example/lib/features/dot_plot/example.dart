import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

class DotPlotExample extends StatelessWidget {
  const DotPlotExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DotPlot(
      axes: CartesianAxes(
        xLimits: AxesLimit(20, 100),
        yLimits: AxesLimit(20, 100),
        numberOfTicksOnX: 3,
        numberOfTicksOnY: 3,
        xLabelsBuilder: (x) {
          return x.toStringAsFixed(0);
        },
      ),
      data: [
        DotPlotData(data: [20, 80], name: "Flutter"),
        DotPlotData(data: [56, 67], name: "Python"),
        DotPlotData(data: [89, 32], name: "PHP"),
      ],
    );
  }
}
