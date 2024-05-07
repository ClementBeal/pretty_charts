import 'package:example/features/bar_plot/screens/all_space_basic_bar_plot_screen.dart';
import 'package:example/features/bar_plot/screens/basic_bar_plot_screen.dart';
import 'package:example/features/bar_plot/screens/stacked_bar_plot_screen.dart';
import 'package:flutter/material.dart';

class BarPlotScreen extends StatelessWidget {
  const BarPlotScreen({super.key});

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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const BasicBarPlotScreen(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Full Space Simple Bar Plot"),
            subtitle: const Text("Use all the available space"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const FullSpaceBasicBarPlotScreen(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Stacked Bar Plots"),
            subtitle: const Text("Several bar plots"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const StackedBarPlotScreen(),
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
