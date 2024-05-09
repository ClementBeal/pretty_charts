import 'package:auto_route/auto_route.dart';
import 'package:example/core/config/router/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LinePlotScreen extends StatelessWidget {
  const LinePlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Simple Line Plot"),
            subtitle: const Text("A simple line chart with legends"),
            onTap: () {
              context.pushRoute(const BasicLinePlotRoute());
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Multiple Line Plots"),
            subtitle:
                const Text("Display different line plots on the same canvas"),
            onTap: () {
              context.pushRoute(const MultipleLinePlotsRoute());
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Dashed & Pointed Line Plot"),
            subtitle: const Text("Use dashed & pointed lines"),
            onTap: () {
              context.pushRoute(const DashedPointedLinePlotRoute());
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Animated Line Plot"),
            subtitle: const Text("Different curve and duration"),
            onTap: () {
              context.pushRoute(const AnimatedLinePlotRoute());
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
