import 'package:pretty_charts/pretty_charts.dart';

class TreeMapChartData {
  final String name;
  final double value;
  final List<TreeMapChartData>? children;

  TreeMapChartData({
    required this.name,
    required this.value,
    this.children,
  });

  @override
  String toString() {
    return "$name $value ${children?.length ?? 0} children";
  }

  factory TreeMapChartData.category(
          {required String name, required List<TreeMapChartData> children}) =>
      TreeMapChartData(
        name: name,
        children: children,
        value: children.fold(
          0.0,
          (p, next) => p + next.value,
        ),
      );
}
