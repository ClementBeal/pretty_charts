import 'package:example/features/dependency_wheel/screens/commercial_balance_dependency_wheel_screen.dart';
import 'package:example/features/dependency_wheel/screens/import_export_dependency_wheel_screen.dart';
import 'package:flutter/material.dart';

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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AndroidIphoneDependencyWheelScreen(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Commercial Balande between different countries"),
            subtitle: const Text(""),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ImportExportDependencyWheelScreen(),
                ),
              );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
