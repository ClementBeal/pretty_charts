class LinePlotData {
  final List<double>? x;
  final List<double>? y;
  final String? name;
  final double Function(double x)? onGenerateY;
  final LineStyle lineStyle;

  LinePlotData({
    this.x,
    this.y,
    this.name,
    this.onGenerateY,
    this.lineStyle = LineStyle.solid,
  });
}

enum LineStyle {
  solid,
  dashed,
  point;
}
