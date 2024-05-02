import 'package:flutter/material.dart';

class ColorMap {
  final List<Color> colors;

  late List<ColorTween> tweens;
  late double step;

  ColorMap({required this.colors}) {
    step = 1 / (colors.length - 1);
    tweens = [];

    for (var i = 0; i < colors.length - 1; i++) {
      tweens.add(
        ColorTween(
          begin: colors[i],
          end: colors[i + 1],
        ),
      );
    }
  }

  Color getColor(double value) {
    final id = value ~/ step;
    final tween = tweens[id];

    return tween.lerp((value - step * id) * colors.length)!;
  }
}

final whiteBlueSquential = ColorMap(colors: [Colors.white, Colors.blue]);
final blueGreenRedSquential =
    ColorMap(colors: [Colors.blue.shade900, Colors.green, Colors.red.shade900]);
