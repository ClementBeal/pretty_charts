import 'package:example/features/contour_plot/screens/basic_contour_plot_screen.dart';
import 'package:flutter/material.dart';

class ContourPlotScreen extends StatelessWidget {
  const ContourPlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Contour Line Plot"),
            subtitle: const Text("A simple contour chart"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const BasicContourPlotScreen(),
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
