import 'package:auto_route/auto_route.dart';
import 'package:example/core/config/router/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class BubbleChartScreen extends StatelessWidget {
  const BubbleChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bubble charts"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Basic bubble charts"),
            subtitle: const Text(""),
            onTap: () {
              context.pushRoute(
                const BasicBubbleChartRoute(),
              );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
