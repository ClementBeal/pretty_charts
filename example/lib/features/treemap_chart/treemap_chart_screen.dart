import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:example/core/config/router/app_router.dart';

@RoutePage()
class TreeMapChartScreen extends StatelessWidget {
  const TreeMapChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Basic Treemap chart"),
            subtitle: const Text(""),
            onTap: () {
             context.pushRoute(const BasicTreeMapChartRoute());
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Category Treemap chart"),
            subtitle: const Text(""),
            onTap: () {
              context.pushRoute(const CategoryTreeMapChartRoute());
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
