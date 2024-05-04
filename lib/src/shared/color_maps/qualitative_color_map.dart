import 'dart:ui';

import 'package:pretty_charts/src/shared/color_maps/color_map.dart';

class QualitativeColorMap extends ColorMap {
  QualitativeColorMap({required super.colors});

  @override
  Color getColor(double value) {
    return colors[value ~/ step];
  }
}

final pastel1 = QualitativeColorMap(
  colors: [
    const Color(0xFF77DD77),
    const Color(0xFFAEC6CF),
    const Color(0xFFFFB347),
    const Color(0xFFB39EB5),
    const Color(0xFFFF6961),
    const Color(0xFFFFD1DC),
  ],
);

final pastel17 = QualitativeColorMap(
  colors: [
    const Color(0xFF77DD77),
    const Color(0xFFAEC6CF),
    const Color(0xFFFFB347),
    const Color(0xFFB39EB5),
    const Color(0xFFFF6961),
    const Color(0xFFFFD1DC),
    const Color(0xFFE9FAE3),
    const Color(0xFFABC798),
    const Color(0xFFD90368),
    const Color(0xFF2E294E),
    const Color(0xFFFFD400),
    const Color(0xFFC1666B),
    const Color(0xFFD4B483),
    const Color(0xFF768948),
    const Color(0xFF533745),
    const Color(0xFF3a4454),
    const Color(0xFF031d44),
  ],
);
