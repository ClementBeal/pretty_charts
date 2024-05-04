import 'package:flutter/material.dart';
import 'dart:math' as math;

class PiePlotConfig {
  /// a % saying that the middle hole will take X% of the width/height
  final double holeRadiusRatio;

  /// show labels in the middle of the arcs
  final bool showLabels;

  /// draw borders of the arcs
  final bool drawBorders;

  /// generate the labels
  /// value is the current value of the pie section
  /// valuePercentage is the normalized value -> [0,1]
  /// name is the section's name
  final String Function(double value, double valuePercentage, String name)?
      onGenerateLabels;

  /// style of the labels
  final TextStyle labelStyle;

  /// title of the chart
  final String? title;

  /// center the title (in the hole)
  final bool centeredTitle;

  // style for the title
  final TextStyle titleStyle;

  /// All the sections are computed like this : value / (sum of all the values)
  ///
  /// In some cases, you want to pass a sum of values that is different. It will be use to compute a
  /// different percentage value for the labels.
  final double? totalValue;

  /// initial start angle
  ///
  /// default to -pi/2
  final double startAngle;

  const PiePlotConfig({
    this.holeRadiusRatio = 0.0,
    this.showLabels = false,
    this.drawBorders = false,
    this.onGenerateLabels,
    this.labelStyle = const TextStyle(
      color: Colors.black,
      fontSize: 18,
    ),
    this.titleStyle = const TextStyle(
      color: Colors.black,
      fontSize: 18,
    ),
    this.title,
    this.centeredTitle = false,
    this.totalValue,
    this.startAngle = -math.pi / 2,
  });
}
