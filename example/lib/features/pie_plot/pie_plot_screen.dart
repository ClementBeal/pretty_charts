import 'package:example/features/pie_plot/screens/basic_pie_plot_screen.dart';
import 'package:example/features/pie_plot/screens/country_population_pie_plot_screen.dart';
import 'package:flutter/material.dart';

class PiePlotScreen extends StatelessWidget {
  const PiePlotScreen({super.key});

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
                  builder: (context) => const BasicPiePlotScreen(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Country population"),
            subtitle: const Text("Countries with the biggest population"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CountryPopulationPiePlotScreen(),
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
