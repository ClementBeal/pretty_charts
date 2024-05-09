import 'package:auto_route/auto_route.dart';
import 'package:example/core/config/router/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DotPlotScreen extends StatelessWidget {
  const DotPlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Basic dot plot"),
            subtitle: const Text(""),
            onTap: () {
              context.pushRoute(const BasicDotPlotRoute());
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
