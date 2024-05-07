import 'package:example/features/dependency_wheel/screens/commercial_balance_dependency_wheel_screen.dart';
import 'package:example/features/dependency_wheel/screens/import_export_dependency_wheel_screen.dart';
import 'package:example/features/treemap_chart/screens/basic_treemap_chart_screen.dart';
import 'package:example/features/treemap_chart/screens/category_treemap_chart_screen.dart';
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
            title: Text("Sells of iPhones and Androids"),
            subtitle: Text(""),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AndroidIphoneDependencyWheelScreen(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text("Commercial Balande between different countries"),
            subtitle: Text(""),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ImportExportDependencyWheelScreen(),
                ),
              );
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
