import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

class LinePlotExample extends StatelessWidget {
  const LinePlotExample({super.key});

  @override
  Widget build(BuildContext context) {
    return LinePlot(
      axes: CartesianAxes(
        showGrid: true,
        xLimits: AxesLimit(0, 5),
        yLimits: AxesLimit(0, 5),
        numberOfTicksOnX: 3,
        numberOfTicksOnY: 3,
        bordersToDisplay: [AxesBorder.left, AxesBorder.bottom],
      ),
      data: [
        LinePlotData(
          onGenerateY: (x) => x * x,
        ),
      ],
    );
  }
}
