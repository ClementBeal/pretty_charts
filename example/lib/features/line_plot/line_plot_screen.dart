import 'package:example/features/line_plot/screens/animated_line_plot_screen.dart';
import 'package:example/features/line_plot/screens/dashed_line_plot_screen.dart';
import 'package:example/features/line_plot/screens/life_expentancy_america_screen.dart';
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
            title: const Text("Simple Line Plot"),
            subtitle: const Text("A simple line chart with legends"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SimpleLinePlotScreen(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Multiple Line Plots"),
            subtitle:
                const Text("Display different line plots on the same canvas"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MultipleLinePlotsScreen(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Dashed & Pointed Line Plot"),
            subtitle: const Text("Use dashed & pointed lines"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DashedPointedLinePlotScreen(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Animated Line Plot"),
            subtitle: const Text("Different curve and duration"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AnimatedLinePlotScreen(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Life expentancy in America"),
            subtitle: const Text("Multiple line curves"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LifeExpentancyAmericaScreen(),
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
