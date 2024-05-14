import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:example/core/config/router/app_router.dart';
import 'package:example/core/utils/constants/sizes.dart';
import 'package:example/features/bar_plot/example.dart';
import 'package:example/features/bubble_chart/example.dart';
import 'package:example/features/contour_plot/example.dart';
import 'package:example/features/dependency_wheel/example.dart';
import 'package:example/features/dot_plot/example.dart';
import 'package:example/features/line_plot/example.dart';
import 'package:example/features/pie_plot/example.dart';
import 'package:example/features/scatter_plot/example.dart';
import 'package:example/features/ternary_plot/example.dart';
import 'package:example/features/treemap_chart/example.dart';

@RoutePage()
class SkeletonScreen extends StatelessWidget {
  const SkeletonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(Sizes.kPaddingMedium),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(Sizes.kPaddingMedium),
              child: Text(
                "Basic plots",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const Wrap(
              alignment: WrapAlignment.center,
              spacing: Sizes.kDefaultSpacing,
              runSpacing: Sizes.kDefaultSpacing,
              children: [
                PlotCard(
                  name: "Line Plot",
                  plot: LinePlotExample(),
                  destinationPage: LinePlotRoute(),
                ),
                PlotCard(
                  name: "Bar Plot",
                  plot: BarPlotExample(),
                  destinationPage: BarPlotRoute(),
                ),
                PlotCard(
                  name: "Pie Plot",
                  plot: PiePlotExample(),
                  destinationPage: PiePlotRoute(),
                ),
                PlotCard(
                  name: "Scatter Plot",
                  plot: ScatterPlotExample(),
                  destinationPage: ScatterPlotRoute(),
                ),
                PlotCard(
                  name: "Bubble Chart",
                  plot: BubbleChartExample(),
                  destinationPage: ScatterPlotRoute(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(Sizes.kPaddingMedium),
              child: Text("Other plots",
                  style: Theme.of(context).textTheme.headlineLarge),
            ),
            const Wrap(
              alignment: WrapAlignment.center,
              spacing: Sizes.kDefaultSpacing,
              runSpacing: Sizes.kDefaultSpacing,
              children: [
                PlotCard(
                  name: "Dependency Wheel",
                  plot: DependencyWheelExample(),
                  destinationPage: DependencyWheelRoute(),
                ),
                PlotCard(
                  name: "Ternary Plot",
                  plot: TernaryPlotExample(),
                  destinationPage: TernaryPlotRoute(),
                ),
                PlotCard(
                  name: "Treemap Chart",
                  plot: TreemapChartExample(),
                  destinationPage: TreeMapChartRoute(),
                ),
                PlotCard(
                  name: "Dot Plot",
                  plot: DotPlotExample(),
                  destinationPage: DotPlotRoute(),
                ),
                PlotCard(
                  name: "Contour Plot",
                  plot: ContourPlotExample(),
                  destinationPage: ContourPlotRoute(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PlotCard extends StatelessWidget {
  const PlotCard({
    super.key,
    required this.name,
    required this.plot,
    required this.destinationPage,
  });

  final String name;
  final Widget plot;
  final PageRouteInfo destinationPage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushRoute(destinationPage);
      },
      borderRadius: BorderRadius.circular(Sizes.kBorderRadius),
      child: Container(
        width: 250,
        height: 300,
        padding: const EdgeInsets.all(Sizes.kPaddingSmall),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(Sizes.kBorderRadius),
        ),
        child: Column(
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(Sizes.kPaddingSmall),
                child: IgnorePointer(child: plot),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
