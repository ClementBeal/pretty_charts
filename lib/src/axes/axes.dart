class Axes {
  final (int, int) xLimits;
  final (int, int) yLimits;

  final int numberOfTicksOnX;
  final int numberOfTicksOnY;

  /// legend to write on the plot
  final String? legend;
  final bool showGrid;

  Axes({
    required this.xLimits,
    required this.yLimits,
    required this.numberOfTicksOnX,
    required this.numberOfTicksOnY,
    this.legend,
    this.showGrid = false,
  });
}
