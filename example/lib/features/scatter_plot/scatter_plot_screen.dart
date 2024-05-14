import 'package:auto_route/auto_route.dart';
import 'package:example/core/config/router/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ScatterPlotScreen extends StatelessWidget {
  const ScatterPlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scatter plots"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Basic scatter plot"),
            subtitle: const Text(""),
            onTap: () {
              context.pushRoute(const BasicScatterPlotRoute());
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Massive Scatter plot"),
            subtitle: const Text("Lot of points (>100 000)"),
            onTap: () {
              context.pushRoute(const MassiveScatterPlotRoute());
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
