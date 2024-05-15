import 'dart:ui';
import 'dart:math' as math;

extension BetterOffset on Offset {
  Offset translateIntoCartesian(double radius, double angle) {
    return Offset(
      dx + (math.cos(angle) * radius),
      dy + (math.sin(angle) * radius),
    );
  }
}
