import 'package:auto_route/auto_route.dart';
import 'package:example/core/config/router/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DependencyWheelScreen extends StatelessWidget {
  const DependencyWheelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Sells of iPhones and Androids"),
            subtitle: const Text(""),
            onTap: () {
              context.pushRoute(const AndroidIphoneDependencyWheelRoute());
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Commercial Balande between different countries"),
            subtitle: const Text(""),
            onTap: () {
              context.pushRoute(const ImportExportDependencyWheelRoute());
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
