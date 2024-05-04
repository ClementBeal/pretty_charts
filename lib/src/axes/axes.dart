abstract class Axes {}

class CartesianAxes extends Axes {
  final AxesLimit xLimits;
  final AxesLimit yLimits;

  final int numberOfTicksOnX;
  final int numberOfTicksOnY;

  /// legend to write on the plot
  final String? title;

  /// show the grid or not
  final bool showGrid;

  ///
  final String Function(double x)? xLabelsBuilder;

  ///
  final String Function(double y)? yLabelsBuilder;

  ///
  final String? xTitle;

  ///
  final String? yTitle;

  ///
  final List<AxesBorder> bordersToDisplay;

  ///
  final List<AxesBorder> arrowsToDisplay;

  CartesianAxes({
    required this.xLimits,
    required this.yLimits,
    required this.numberOfTicksOnX,
    required this.numberOfTicksOnY,
    this.title,
    this.xTitle,
    this.yTitle,
    this.showGrid = false,
    this.xLabelsBuilder,
    this.yLabelsBuilder,
    this.bordersToDisplay = AxesBorder.values,
    this.arrowsToDisplay = const [],
  });
}

class AxesLimit {
  final double minLimit;
  final double maxLimit;

  AxesLimit(this.minLimit, this.maxLimit);

  double getDiff() {
    return maxLimit - minLimit;
  }

  AxesLimit scale(double scaleFactor) {
    return AxesLimit(
      minLimit / scaleFactor,
      maxLimit / scaleFactor,
    );
  }

  AxesLimit translate(double value) {
    return AxesLimit(minLimit + value, maxLimit + value);
  }
}

enum AxesBorder {
  left,
  top,
  right,
  bottom;
}
