import 'package:flutter/material.dart';
import 'package:pretty_charts/src/shared/color_maps/color_map.dart';

class ContinuousColorMap extends ColorMap {
  late List<ColorTween> tweens;

  ContinuousColorMap({required super.colors}) {
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

  @override
  Color getColor(double value) {
    final id = value ~/ step;
    final tween = tweens[id];

    return tween.lerp((value - step * id) * colors.length)!;
  }
}

final whiteBlueSquential =
    ContinuousColorMap(colors: [Colors.white, Colors.blue]);
final blueGreenRedSquential = ContinuousColorMap(
    colors: [Colors.blue.shade900, Colors.green, Colors.red.shade900]);
