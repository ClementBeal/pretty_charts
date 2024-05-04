import 'package:flutter/widgets.dart';
import 'package:pretty_charts/src/axes/axes.dart';

class TernaryPlotData {
  final List<TernaryPosition> data;
  final String name;

  TernaryPlotData({
    required this.name,
    required this.data,
  });
}

class TernaryPosition {
  final double leftAxesValue;
  final double rightAxesValue;
  final double bottomAxesValue;

  TernaryPosition({
    required this.leftAxesValue,
    required this.rightAxesValue,
    required this.bottomAxesValue,
  });

  double get sum => leftAxesValue + rightAxesValue + bottomAxesValue;

  // 0.866025404 -> sqrt(3)/2
  Offset get toCartesian => Offset(
        0.5 * (2 * rightAxesValue + leftAxesValue) / sum,
        0.866025404 * leftAxesValue / sum,
      );
}

class TernaryPlotAxes extends Axes {
  final bool showMajorLines;

  final String leftAxesTitle;
  final String rightAxesTitle;
  final String bottomAxesTitle;

  TernaryPlotAxes({
    this.showMajorLines = true,
    required this.leftAxesTitle,
    required this.rightAxesTitle,
    required this.bottomAxesTitle,
  });
}
