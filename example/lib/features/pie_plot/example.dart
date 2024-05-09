import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

class PiePlotExample extends StatelessWidget {
  const PiePlotExample({super.key});

  @override
  Widget build(BuildContext context) {
    return PiePlot(
      data: [
        PiePlotData(
          name: '',
          value: 22.3,
        ),
        PiePlotData(
          name: '',
          value: 42.3,
        ),
        PiePlotData(
          name: '',
          value: 4.3,
        ),
        PiePlotData(
          name: '',
          value: 6.3,
        ),
      ],
    );
  }
}
