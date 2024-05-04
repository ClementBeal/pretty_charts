import 'package:example/features/bar_plot/bar_plot.dart';
import 'package:example/features/contour_plot/contour_plot_screen.dart';
import 'package:example/features/line_plot/line_plot_screen.dart';
import 'package:example/features/pie_plot/pie_plot_screen.dart';
import 'package:example/features/scatter_plot/scatter_plot_screen.dart';
import 'package:example/features/ternary_plot/ternary_plot.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pretty Charts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: const Text("Line Chart"),
            subtitle: const Text(""),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LinePlotScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Contour Chart"),
            subtitle: const Text(""),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ContourPlotScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Bar Chart"),
            subtitle: const Text(""),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const BarPlotScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Ternary Plot"),
            subtitle: const Text(""),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TernaryPlotScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Pie Plot"),
            subtitle: const Text(""),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PiePlotScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Scatter Plot"),
            subtitle: const Text(""),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ScatterPlotScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
