class TreeMapChartData {
  final String name;
  final double value;
  final List<TreeMapChartData>? children;

  TreeMapChartData({
    required this.name,
    required this.value,
    this.children,
  });

  double? normalizedValue;

  @override
  String toString() {
    return "$name $value ${children?.length ?? 0} children";
  }

  TreeMapChartData normalizeValue(double normalizedValue) => TreeMapChartData(
        name: name,
        children: children,
        value: value,
      )..normalizedValue = normalizedValue;

  factory TreeMapChartData.category(
          {required String name, required List<TreeMapChartData> children}) =>
      TreeMapChartData(
        name: name,
        children: children,
        value: children.fold(
          0.0,
          (p, next) => p + next.value,
        ),
      )..normalizedValue = children.fold(
          0.0,
          (p, next) => (p ?? 0.0) + (next.normalizedValue ?? 0.0),
        );
}
