import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

@RoutePage()
class BasicDotPlotScreen extends StatelessWidget {
  const BasicDotPlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox.expand(
        child: DotPlot(
            axes: CartesianAxes(
              xLimits: AxesLimit(0, 10),
              yLimits: AxesLimit(0, 10),
              numberOfTicksOnX: 5,
              numberOfTicksOnY: 5,
              xLabelsBuilder: (x) {
                return (x / 1000).toStringAsFixed(0);
              },
            ),
            data: [
              DotPlotData(data: [87400, 123000], name: "Brown"),
              DotPlotData(data: [93200, 135000], name: "NYU"),
              DotPlotData(data: [91000, 131000], name: "Notre Dame"),
              DotPlotData(data: [94500, 138000], name: "Cornell"),
              DotPlotData(data: [90100, 129000], name: "Tufts"),
              DotPlotData(data: [98700, 142000], name: "Yale"),
              DotPlotData(data: [99800, 143000], name: "Dartmouth"),
              DotPlotData(data: [95500, 137000], name: "Chicago"),
              DotPlotData(data: [96500, 140000], name: "Columbia"),
              DotPlotData(data: [99000, 145000], name: "Duke"),
              DotPlotData(data: [97200, 141000], name: "Georgetown"),
              DotPlotData(data: [100000, 146000], name: "Princeton"),
              DotPlotData(data: [98000, 144000], name: "U.Penn"),
              DotPlotData(data: [105000, 150000], name: "Stanford"),
              DotPlotData(data: [102000, 148000], name: "MIT"),
              DotPlotData(data: [107000, 155000], name: "Harvard")
            ]),
      ),
    );
  }
}
