import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:example/core/config/router/app_router.dart';

@RoutePage()
class TernaryPlotScreen extends StatelessWidget {
  const TernaryPlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Simple Ternary Plot"),
            subtitle: const Text("A simple Ternary chart"),
            onTap: () {
              context.pushRoute(const BasicTernaryPlotRoute());
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Soil Ternary Plot"),
            subtitle: const Text("An example using soil data"),
            onTap: () {
              context.pushRoute(const SoilTernaryPlotRoute());
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
