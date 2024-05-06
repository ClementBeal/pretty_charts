import 'package:example/features/treemap_chart/screens/basic_treemap_chart_screen.dart';
import 'package:example/features/treemap_chart/screens/category_treemap_chart_screen.dart';
import 'package:flutter/material.dart';

class TreeMapChartScreen extends StatelessWidget {
  const TreeMapChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            title: Text("Basic Treemap chart"),
            subtitle: Text(""),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BasicTreeMapChartScreen(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text("Category Treemap chart"),
            subtitle: Text(""),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CategoryTreeMapChartScreen(),
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
