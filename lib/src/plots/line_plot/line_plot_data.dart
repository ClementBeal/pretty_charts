import 'package:flutter/material.dart';

class LinePlotData {
  final double Function(double x) onGenerate;
  final Color lineColor;
  final LineStyle lineStyle;

  LinePlotData({
    required this.onGenerate,
    this.lineColor = const Color.fromARGB(255, 69, 104, 77),
    this.lineStyle = LineStyle.solid,
  });
}

enum LineStyle {
  solid,
  dashed,
  point;
}
