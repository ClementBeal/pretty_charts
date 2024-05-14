import 'package:auto_route/auto_route.dart';
import 'package:example/core/config/router/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PiePlotScreen extends StatelessWidget {
  const PiePlotScreen({super.key});

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
              context.pushRoute(const BasicPiePlotRoute());
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Country population"),
            subtitle: const Text("Countries with the biggest population"),
            onTap: () {
              context.pushRoute(const CountryPopulationPiePlotRoute());
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
