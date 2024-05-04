import 'package:example/features/ternary_plot/screens/basic_ternary_plot_screen.dart';
import 'package:example/features/ternary_plot/screens/soil_ternay_plot_screen.dart';
import 'package:flutter/material.dart';

class TernaryPlotScreen extends StatelessWidget {
  const TernaryPlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Simple Ternary Plot"),
            subtitle: const Text("A simple Ternary chart"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const BasicTernaryPlotScreen(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Soil Ternary Plot"),
            subtitle: const Text("An example using soil data"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SoilTernaryPlotScreen(),
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
