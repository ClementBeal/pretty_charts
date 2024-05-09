import 'package:auto_route/auto_route.dart';
import 'package:example/core/config/router/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ContourPlotScreen extends StatelessWidget {
  const ContourPlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Contour Line Plot"),
            subtitle: const Text("A simple contour chart"),
            onTap: () {
              context.pushRoute(
                const BasicContourPlotRoute(),
              );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
