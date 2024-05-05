import 'package:example/features/dot_plot/screens/basic_dot_plot_screen.dart';
import 'package:flutter/material.dart';

class DotPlotScreen extends StatelessWidget {
  const DotPlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            title: Text("Basic dot plot"),
            subtitle: Text(""),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BasicDotPlotScreen(),
              ));
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
