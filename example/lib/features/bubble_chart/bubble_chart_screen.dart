import 'package:example/features/bubble_chart/screens/basic_bubble_chart_screen.dart';
import 'package:flutter/material.dart';

class BubbleChartScreen extends StatelessWidget {
  const BubbleChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bubble charts"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Basic bubble charts"),
            subtitle: Text(""),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BasicBubbleChart(),
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
