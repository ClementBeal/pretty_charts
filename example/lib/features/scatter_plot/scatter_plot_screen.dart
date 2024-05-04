import 'package:example/features/scatter_plot/screens/basic_scatter_plot.dart';
import 'package:example/features/scatter_plot/screens/massive_scatter_plot.dart';
import 'package:flutter/material.dart';

class ScatterPlotScreen extends StatelessWidget {
  const ScatterPlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scatter plots"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Basic scatter plot"),
            subtitle: Text(""),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BasicScatterPlot(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text("Massive Scatter plot"),
            subtitle: Text("Lot of points (>100 000)"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MassiveScatterPlot(),
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
