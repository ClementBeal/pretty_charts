import 'package:example/features/line_plot/screens/multiple_line_plots_screen.dart';
import 'package:example/features/line_plot/screens/simple_line_plot_screen.dart';
import 'package:flutter/material.dart';

class LinePlotScreen extends StatelessWidget {
  const LinePlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            title: Text("Simple Line Plot"),
            subtitle: Text("A simple line chart with legends"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SimpleLinePlotScreen(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text("Multiple Line Plots"),
            subtitle: Text("Display different line plots on the same canvas"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MultipleLinePlotsScreen(),
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
