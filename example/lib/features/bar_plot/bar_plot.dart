import 'package:auto_route/auto_route.dart';
import 'package:example/core/config/router/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class BarPlotScreen extends StatelessWidget {
  const BarPlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Simple Bar Plot"),
            subtitle: const Text("A simple bar chart"),
            onTap: () {
              context.pushRoute(
                const BasicBarPlotRoute(),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Full Space Simple Bar Plot"),
            subtitle: const Text("Use all the available space"),
            onTap: () {
              context.pushRoute(
                const FullSpaceBasicBarPlotRoute(),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Stacked Bar Plots"),
            subtitle: const Text("Several bar plots"),
            onTap: () {
              context.pushRoute(
                const StackedBarPlotRoute(),
              );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
