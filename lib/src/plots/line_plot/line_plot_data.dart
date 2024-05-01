import 'package:flutter/material.dart';

class LinePlotData {
  final double Function(double x) onGenerate;
  final Color lineColor;

  LinePlotData({
    required this.onGenerate,
    this.lineColor = const Color.fromARGB(255, 69, 104, 77),
  });
}
