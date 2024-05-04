import 'dart:ui';

abstract class ColorMap {
  final List<Color> colors;

  late double step;

  ColorMap({required this.colors}) {
    step = 1 / (colors.length - 1);
  }

  void reset();

  Color getColor(double value);
}
