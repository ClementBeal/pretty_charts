import 'package:example/features/scatter_plot/screens/basic_scatter_plot.dart';
import 'package:example/features/scatter_plot/screens/massive_scatter_plot.dart';
import 'package:flutter/material.dart';

class ScatterPlotScreen extends StatelessWidget {
  const ScatterPlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scatter plots"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Basic scatter plot"),
            subtitle: const Text(""),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const BasicScatterPlot(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Massive Scatter plot"),
            subtitle: const Text("Lot of points (>100 000)"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MassiveScatterPlot(),
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
