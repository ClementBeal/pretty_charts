import 'dart:math';

import 'package:example/features/grid_layout/grid_layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:example/features/bar_plot/bar_plot.dart';
import 'package:example/features/contour_plot/contour_plot_screen.dart';
import 'package:example/features/dependency_wheel/dependency_wheel_screen.dart';
import 'package:example/features/dot_plot/dot_plot_screen.dart';
import 'package:example/features/line_plot/line_plot_screen.dart';
import 'package:example/features/pie_plot/pie_plot_screen.dart';
import 'package:example/features/scatter_plot/scatter_plot_screen.dart';
import 'package:example/features/ternary_plot/ternary_plot.dart';
import 'package:example/features/treemap_chart/treemap_chart_screen.dart';
import 'package:pretty_charts/pretty_charts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const TitleText("Basic"),
          const BasicPlotGrid(),
          const TitleText("Specials"),
          const SpecialChartsGrid(),
          TitleText("Layouts"),
          const LayoutGrid(),
        ],
      ),
    );
  }
}

class LayoutGrid extends StatelessWidget {
  const LayoutGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      children: [
        PlotCard(
          name: "Grid layout",
          destinationPage: GridLayoutScreen(),
          plot: GridPlotLayout(
            pattern: """
AL""",
            orders: "AL",
            children: [
              LinePlot(
                axes: CartesianAxes(
                  xLimits: AxesLimit(0, 5),
                  yLimits: AxesLimit(0, 5),
                  numberOfTicksOnX: 3,
                  numberOfTicksOnY: 3,
                ),
                data: [
                  LinePlotData(
                    onGenerateY: (x) => x,
                  ),
                ],
              ),
              LinePlot(
                axes: CartesianAxes(
                  xLimits: AxesLimit(0, 5),
                  yLimits: AxesLimit(0, 5),
                  numberOfTicksOnX: 3,
                  numberOfTicksOnY: 3,
                ),
                data: [
                  LinePlotData(
                    onGenerateY: (x) => x,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SpecialChartsGrid extends StatelessWidget {
  const SpecialChartsGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      children: [
        PlotCard(
          name: "Dependency Wheel",
          plot: DependencyWheelChart(
            sectionSpacing: 0.2,
            data: [
              DependencyWheelChartData(from: "A", to: "B", value: 2),
              DependencyWheelChartData(from: "A", to: "C", value: 1),
              DependencyWheelChartData(from: "C", to: "B", value: 4),
            ],
          ),
          destinationPage: const DependencyWheelScreen(),
        ),
        PlotCard(
          name: "Ternary Plot",
          plot: TernaryPlot(
            colorMap: pastel2,
            data: [
              TernaryPlotData(
                name: "",
                data: [
                  TernaryPosition(
                    leftAxesValue: 0,
                    rightAxesValue: 0,
                    bottomAxesValue: 100,
                  ),
                  TernaryPosition(
                    leftAxesValue: 30,
                    rightAxesValue: 0,
                    bottomAxesValue: 90,
                  ),
                  TernaryPosition(
                    leftAxesValue: 0,
                    rightAxesValue: 30,
                    bottomAxesValue: 90,
                  ),
                ],
              ),
              TernaryPlotData(
                name: "",
                data: [
                  TernaryPosition(
                      leftAxesValue: 100,
                      bottomAxesValue: 0,
                      rightAxesValue: 0),
                  TernaryPosition(
                      leftAxesValue: 80,
                      bottomAxesValue: 40,
                      rightAxesValue: 0),
                  TernaryPosition(
                      leftAxesValue: 40,
                      bottomAxesValue: 40,
                      rightAxesValue: 40),
                ],
              ),
            ],
            axes: TernaryPlotAxes(
              leftAxesTitle: "Water",
              rightAxesTitle: "Salt",
              bottomAxesTitle: "Sugar",
            ),
          ),
          destinationPage: const TernaryPlotScreen(),
        ),
        PlotCard(
          name: "Treemap Chart",
          plot: TreeMapChart(
            interactions: [],
            data: [
              TreeMapChartData(name: "France", value: 54),
              TreeMapChartData(name: "Italy", value: 22),
              TreeMapChartData(name: "Spain", value: 10),
              TreeMapChartData(name: "Portugal", value: 5),
              TreeMapChartData(name: "UK", value: 2),
            ],
          ),
          destinationPage: const TreeMapChartScreen(),
        ),
        PlotCard(
          name: "Dot Chart",
          plot: DotPlot(
            axes: CartesianAxes(
              xLimits: AxesLimit(20, 100),
              yLimits: AxesLimit(20, 100),
              numberOfTicksOnX: 3,
              numberOfTicksOnY: 3,
              xLabelsBuilder: (x) {
                return x.toStringAsFixed(0);
              },
            ),
            data: [
              DotPlotData(data: [20, 80], name: "Flutter"),
              DotPlotData(data: [56, 67], name: "Python"),
              DotPlotData(data: [89, 32], name: "PHP"),
            ],
          ),
          destinationPage: const DotPlotScreen(),
        ),
        PlotCard(
          name: "Contour Plot",
          plot: ContourPlot(
            axes: CartesianAxes(
              xLimits: AxesLimit(0, 5),
              yLimits: AxesLimit(0, 5),
              numberOfTicksOnX: 3,
              numberOfTicksOnY: 3,
            ),
            data: [
              ContourPlotData(
                onGenerate: (x, y) {
                  return sin(x) + sin(y);
                },
                nbLines: 20,
              ),
            ],
          ),
          destinationPage: const ContourPlotScreen(),
        ),
      ],
    );
  }
}

class BasicPlotGrid extends StatelessWidget {
  const BasicPlotGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      children: [
        PlotCard(
          name: "Line Plot",
          plot: LinePlot(
            axes: CartesianAxes(
              showGrid: true,
              xLimits: AxesLimit(0, 5),
              yLimits: AxesLimit(0, 5),
              numberOfTicksOnX: 3,
              numberOfTicksOnY: 3,
              bordersToDisplay: [AxesBorder.left, AxesBorder.bottom],
            ),
            data: [
              LinePlotData(
                onGenerateY: (x) => x * x,
              ),
            ],
          ),
          destinationPage: const LinePlotScreen(),
        ),
        PlotCard(
          name: "Bar Plot",
          plot: BarPlot(
            axes: CartesianAxes(
              showGrid: true,
              xLimits: AxesLimit(0, 5),
              yLimits: AxesLimit(0, 5),
              numberOfTicksOnX: 3,
              numberOfTicksOnY: 3,
              bordersToDisplay: [AxesBorder.left, AxesBorder.bottom],
            ),
            data: [
              BarPlotData(
                x: [0, 1, 2],
                y: [3, 4, 1],
              ),
            ],
          ),
          destinationPage: const BarPlotScreen(),
        ),
        PlotCard(
          name: "Pie Plot",
          plot: PiePlot(
            data: [
              PiePlotData(
                name: '',
                value: 22.3,
              ),
              PiePlotData(
                name: '',
                value: 42.3,
              ),
              PiePlotData(
                name: '',
                value: 4.3,
              ),
              PiePlotData(
                name: '',
                value: 6.3,
              ),
            ],
          ),
          destinationPage: const PiePlotScreen(),
        ),
        PlotCard(
          name: "Scatter Plot",
          plot: ScatterPlot(
            data: [
              ScatterPlotData(
                x: [0, 1, 2, 3, 4, 5, 4, 3],
                y: [0, 1, 2, 3, 4, 5, 3, 1],
                name: "",
              ),
              ScatterPlotData(
                x: [0, 1, 2, 3, 4],
                y: [3, 4, 1, 1.2, 5],
                name: "",
              )
            ],
            axes: CartesianAxes(
              xLimits: AxesLimit(0, 5),
              yLimits: AxesLimit(0, 5),
              numberOfTicksOnX: 3,
              numberOfTicksOnY: 3,
              showGrid: true,
            ),
          ),
          destinationPage: const ScatterPlotScreen(),
        ),
        PlotCard(
          name: "Bubble Chart",
          plot: BubbleChart(
            colorMap: pastel2,
            data: [
              BubbleChartData(
                x: [0, 1, 2, 3, 4, 5],
                y: [3, 2, 5, 4, 4.3, 2.3],
                z: [4, 3, 8, 1, 9, 2],
                name: "",
              ),
              BubbleChartData(
                x: [2.2, 3.3, 4.4, 0.3, 2.9, 4],
                y: [0.5, 0.7, 2.9, 3.9, 4.4, 1.1],
                z: [3, 3, 3, 2.8, 1.2, 5.4],
                name: "",
              ),
            ],
            axes: CartesianAxes(
              xLimits: AxesLimit(0, 5),
              yLimits: AxesLimit(0, 5),
              numberOfTicksOnX: 3,
              numberOfTicksOnY: 3,
              showGrid: true,
            ),
          ),
          destinationPage: const ScatterPlotScreen(),
        ),
      ],
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.displayMedium);
  }
}

class PlotCard extends StatelessWidget {
  const PlotCard(
      {super.key,
      required this.name,
      required this.plot,
      required this.destinationPage});

  final String name;
  final Widget plot;
  final Widget destinationPage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => destinationPage,
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: plot,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
