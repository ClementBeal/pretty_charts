class ContourPlotData {
  final double Function(double x, double y) onGenerate;
  final int nbLines;

  ContourPlotData({
    required this.onGenerate,
    required this.nbLines,
  });
}
