import 'package:auto_route/auto_route.dart';
import 'package:example/features/bar_plot/bar_plot.dart';
import 'package:example/features/bar_plot/screens/all_space_basic_bar_plot_screen.dart';
import 'package:example/features/bar_plot/screens/basic_bar_plot_screen.dart';
import 'package:example/features/bar_plot/screens/stacked_bar_plot_screen.dart';
import 'package:example/features/bubble_chart/bubble_chart_screen.dart';
import 'package:example/features/bubble_chart/screens/basic_bubble_chart_screen.dart';
import 'package:example/features/contour_plot/contour_plot_screen.dart';
import 'package:example/features/contour_plot/screens/basic_contour_plot_screen.dart';
import 'package:example/features/dependency_wheel/dependency_wheel_screen.dart';
import 'package:example/features/dependency_wheel/screens/commercial_balance_dependency_wheel_screen.dart';
import 'package:example/features/dependency_wheel/screens/import_export_dependency_wheel_screen.dart';
import 'package:example/features/dot_plot/dot_plot_screen.dart';
import 'package:example/features/dot_plot/screens/basic_dot_plot_screen.dart';
import 'package:example/features/line_plot/line_plot_screen.dart';
import 'package:example/features/line_plot/screens/animated_line_plot_screen.dart';
import 'package:example/features/line_plot/screens/dashed_line_plot_screen.dart';
import 'package:example/features/line_plot/screens/multiple_line_plots_screen.dart';
import 'package:example/features/line_plot/screens/basic_line_plot_screen.dart';
import 'package:example/features/pie_plot/pie_plot_screen.dart';
import 'package:example/features/pie_plot/screens/basic_pie_plot_screen.dart';
import 'package:example/features/pie_plot/screens/country_population_pie_plot_screen.dart';
import 'package:example/features/scatter_plot/scatter_plot_screen.dart';
import 'package:example/features/scatter_plot/screens/basic_scatter_plot.dart';
import 'package:example/features/scatter_plot/screens/massive_scatter_plot.dart';
import 'package:example/features/ternary_plot/screens/basic_ternary_plot_screen.dart';
import 'package:example/features/ternary_plot/screens/soil_ternay_plot_screen.dart';
import 'package:example/features/ternary_plot/ternary_plot.dart';
import 'package:example/features/treemap_chart/screens/basic_treemap_chart_screen.dart';
import 'package:example/features/treemap_chart/screens/category_treemap_chart_screen.dart';
import 'package:example/features/treemap_chart/treemap_chart_screen.dart';
import 'package:example/features/skeleton/skeleton_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: SkeletonRoute.page,
          initial: true,
        ),
        // Bar plot routes
        AutoRoute(
          path: '/bar_plot',
          page: BarPlotRoute.page,
        ),
        AutoRoute(
          path: '/bar_plot/full_space',
          page: FullSpaceBasicBarPlotRoute.page,
        ),
        AutoRoute(
          path: '/bar_plot/basic',
          page: BasicBarPlotRoute.page,
        ),
        AutoRoute(
          path: '/bar_plot/stacked',
          page: StackedBarPlotRoute.page,
        ),
        // Bubble chart routes
        AutoRoute(
          path: '/bubble_chart',
          page: BubbleChartRoute.page,
        ),
        AutoRoute(
          path: '/bubble_chart/basic',
          page: BasicBubbleChartRoute.page,
        ),
        // Contour plot routes
        AutoRoute(
          path: '/contour_plot',
          page: ContourPlotRoute.page,
        ),
        AutoRoute(
          path: '/contour_plot/basic',
          page: BasicContourPlotRoute.page,
        ),
        // Dependency wheel routes
        AutoRoute(
          path: '/dependency_wheel',
          page: DependencyWheelRoute.page,
        ),
        AutoRoute(
          path: '/dependency_wheel/commercial_balance',
          page: AndroidIphoneDependencyWheelRoute.page,
        ),
        AutoRoute(
          path: '/dependency_wheel/import_export',
          page: ImportExportDependencyWheelRoute.page,
        ),
        // Dot plot routes
        AutoRoute(
          path: '/dot_plot',
          page: DotPlotRoute.page,
        ),
        AutoRoute(
          path: '/dot_plot/basic',
          page: BasicDotPlotRoute.page,
        ),
        // Line plot routes
        AutoRoute(
          path: '/line_plot',
          page: LinePlotRoute.page,
        ),
        AutoRoute(
          path: '/line_plot/basic',
          page: BasicLinePlotRoute.page,
        ),
        AutoRoute(
          path: '/line_plot/dashed_pointed',
          page: DashedPointedLinePlotRoute.page,
        ),
        AutoRoute(
          path: '/line_plot/animated',
          page: AnimatedLinePlotRoute.page,
        ),
        AutoRoute(
          path: '/line_plot/multiple',
          page: MultipleLinePlotsRoute.page,
        ),
        // Pie plot routes
        AutoRoute(
          path: '/pie_plot',
          page: PiePlotRoute.page,
        ),
        AutoRoute(
          path: '/pie_plot/basic',
          page: BasicPiePlotRoute.page,
        ),
        AutoRoute(
          path: '/pie_plot/country_population',
          page: CountryPopulationPiePlotRoute.page,
        ),
        // Scatter plot routes
        AutoRoute(
          path: '/scatter_plot',
          page: ScatterPlotRoute.page,
        ),
        AutoRoute(
          path: '/scatter_plot/basic',
          page: BasicScatterPlotRoute.page,
        ),
        AutoRoute(
          path: '/scatter_plot/masive',
          page: MassiveScatterPlotRoute.page,
        ),
        // Ternary plot routes
        AutoRoute(
          path: '/ternary_plot',
          page: TernaryPlotRoute.page,
        ),
        AutoRoute(
          path: '/ternary_plot/basic',
          page: BasicTernaryPlotRoute.page,
        ),
        AutoRoute(
          path: '/ternary_plot/soil',
          page: SoilTernaryPlotRoute.page,
        ),
        // Treemap chart routes
        AutoRoute(
          path: '/treemap_chart',
          page: TreeMapChartRoute.page,
        ),
        AutoRoute(
          path: '/treemap_chart/basic',
          page: BasicTreeMapChartRoute.page,
        ),
        AutoRoute(
          path: '/treemap_chart/category',
          page: CategoryTreeMapChartRoute.page,
        ),
      ];
}

final appRouter = AppRouter();
