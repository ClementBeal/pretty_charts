import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pretty_charts/pretty_charts.dart';

// https://gist.github.com/davenquinn/988167471993bc2ece29
@RoutePage()
class SoilTernaryPlotScreen extends StatelessWidget {
  const SoilTernaryPlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          width: 600,
          height: 600,
          child: TernaryPlot(
            axes: TernaryPlotAxes(
              showMajorLines: true,
              leftAxesTitle: "Clay",
              rightAxesTitle: "Slit",
              bottomAxesTitle: "Sand",
            ),
            colorMap: pastel17,
            data: [
              TernaryPlotData(
                name: "sand",
                data: [
                  TernaryPosition(
                    leftAxesValue: 0,
                    rightAxesValue: 0,
                    bottomAxesValue: 100,
                  ),
                  TernaryPosition(
                    leftAxesValue: 10,
                    rightAxesValue: 0,
                    bottomAxesValue: 90,
                  ),
                  TernaryPosition(
                    leftAxesValue: 0,
                    rightAxesValue: 10,
                    bottomAxesValue: 90,
                  ),
                ],
              ),
              TernaryPlotData(
                name: "clay",
                data: [
                  TernaryPosition(
                    leftAxesValue: 55,
                    bottomAxesValue: 45,
                    rightAxesValue: 0,
                  ),
                  TernaryPosition(
                      leftAxesValue: 100,
                      bottomAxesValue: 0,
                      rightAxesValue: 0),
                  TernaryPosition(
                    leftAxesValue: 60,
                    bottomAxesValue: 0,
                    rightAxesValue: 40,
                  ),
                  TernaryPosition(
                      leftAxesValue: 40,
                      bottomAxesValue: 20,
                      rightAxesValue: 40),
                  TernaryPosition(
                      leftAxesValue: 40,
                      bottomAxesValue: 45,
                      rightAxesValue: 15),
                ],
              ),
              TernaryPlotData(
                name: "silt",
                data: [
                  TernaryPosition(
                    leftAxesValue: 0,
                    bottomAxesValue: 0,
                    rightAxesValue: 100,
                  ),
                  TernaryPosition(
                    leftAxesValue: 0,
                    bottomAxesValue: 20,
                    rightAxesValue: 80,
                  ),
                  TernaryPosition(
                    leftAxesValue: 12,
                    bottomAxesValue: 8,
                    rightAxesValue: 80,
                  ),
                  TernaryPosition(
                    leftAxesValue: 12,
                    bottomAxesValue: 0,
                    rightAxesValue: 88,
                  ),
                ],
              ),
              TernaryPlotData(
                name: "loamy sand",
                data: [
                  TernaryPosition(
                      leftAxesValue: 0,
                      bottomAxesValue: 90,
                      rightAxesValue: 10),
                  TernaryPosition(
                      leftAxesValue: 10,
                      bottomAxesValue: 90,
                      rightAxesValue: 0),
                  TernaryPosition(
                      leftAxesValue: 15,
                      bottomAxesValue: 85,
                      rightAxesValue: 0),
                  TernaryPosition(
                    leftAxesValue: 0,
                    bottomAxesValue: 70,
                    rightAxesValue: 30,
                  ),
                ],
              ),
              TernaryPlotData(
                name: "sandy loam",
                data: [
                  TernaryPosition(
                      leftAxesValue: 0,
                      bottomAxesValue: 70,
                      rightAxesValue: 30),
                  TernaryPosition(
                      leftAxesValue: 15,
                      bottomAxesValue: 85,
                      rightAxesValue: 0),
                  TernaryPosition(
                      leftAxesValue: 20,
                      bottomAxesValue: 80,
                      rightAxesValue: 0),
                  TernaryPosition(
                      leftAxesValue: 20,
                      bottomAxesValue: 53,
                      rightAxesValue: 32),
                  TernaryPosition(
                      leftAxesValue: 5,
                      bottomAxesValue: 53,
                      rightAxesValue: 42),
                  TernaryPosition(
                      leftAxesValue: 5,
                      bottomAxesValue: 45,
                      rightAxesValue: 50),
                  TernaryPosition(
                      leftAxesValue: 0,
                      bottomAxesValue: 50,
                      rightAxesValue: 50),
                ],
              ),
              TernaryPlotData(
                name: "sandy clay loam",
                data: [
                  TernaryPosition(
                      leftAxesValue: 20,
                      bottomAxesValue: 80,
                      rightAxesValue: 0),
                  TernaryPosition(
                      leftAxesValue: 35,
                      bottomAxesValue: 65,
                      rightAxesValue: 0),
                  TernaryPosition(
                      leftAxesValue: 35,
                      bottomAxesValue: 45,
                      rightAxesValue: 20),
                  TernaryPosition(
                      leftAxesValue: 28,
                      bottomAxesValue: 45,
                      rightAxesValue: 27),
                  TernaryPosition(
                      leftAxesValue: 20,
                      bottomAxesValue: 53,
                      rightAxesValue: 32),
                ],
              ),
              TernaryPlotData(
                name: "sandy clay",
                data: [
                  TernaryPosition(
                      leftAxesValue: 35,
                      bottomAxesValue: 65,
                      rightAxesValue: 0),
                  TernaryPosition(
                      leftAxesValue: 35,
                      bottomAxesValue: 45,
                      rightAxesValue: 20),
                  TernaryPosition(
                      leftAxesValue: 55,
                      bottomAxesValue: 45,
                      rightAxesValue: 0),
                ],
              ),
              TernaryPlotData(
                name: "clay loam",
                data: [
                  TernaryPosition(
                      leftAxesValue: 40,
                      bottomAxesValue: 45,
                      rightAxesValue: 15),
                  TernaryPosition(
                      leftAxesValue: 40,
                      bottomAxesValue: 20,
                      rightAxesValue: 40),
                  TernaryPosition(
                      leftAxesValue: 28,
                      bottomAxesValue: 20,
                      rightAxesValue: 52),
                  TernaryPosition(
                      leftAxesValue: 28,
                      bottomAxesValue: 45,
                      rightAxesValue: 27),
                ],
              ),
              TernaryPlotData(
                name: "silty clay",
                data: [
                  TernaryPosition(
                      leftAxesValue: 60,
                      bottomAxesValue: 0,
                      rightAxesValue: 40),
                  TernaryPosition(
                      leftAxesValue: 40,
                      bottomAxesValue: 0,
                      rightAxesValue: 60),
                  TernaryPosition(
                      leftAxesValue: 40,
                      bottomAxesValue: 20,
                      rightAxesValue: 40),
                ],
              ),
              TernaryPlotData(
                name: "silty clay loam",
                data: [
                  TernaryPosition(
                      leftAxesValue: 28,
                      bottomAxesValue: 0,
                      rightAxesValue: 72),
                  TernaryPosition(
                      leftAxesValue: 28,
                      bottomAxesValue: 20,
                      rightAxesValue: 52),
                  TernaryPosition(
                      leftAxesValue: 40,
                      bottomAxesValue: 20,
                      rightAxesValue: 40),
                  TernaryPosition(
                      leftAxesValue: 40,
                      bottomAxesValue: 0,
                      rightAxesValue: 60),
                ],
              ),
              TernaryPlotData(
                name: "silty loam",
                data: [
                  TernaryPosition(
                      leftAxesValue: 0,
                      bottomAxesValue: 50,
                      rightAxesValue: 50),
                  TernaryPosition(
                      leftAxesValue: 28,
                      bottomAxesValue: 22,
                      rightAxesValue: 50),
                  TernaryPosition(
                      leftAxesValue: 28,
                      bottomAxesValue: 0,
                      rightAxesValue: 72),
                  TernaryPosition(
                      leftAxesValue: 12,
                      bottomAxesValue: 0,
                      rightAxesValue: 88),
                  TernaryPosition(
                      leftAxesValue: 12,
                      bottomAxesValue: 8,
                      rightAxesValue: 80),
                  TernaryPosition(
                      leftAxesValue: 0,
                      bottomAxesValue: 20,
                      rightAxesValue: 80),
                ],
              ),
              TernaryPlotData(
                name: "loam",
                data: [
                  TernaryPosition(
                      leftAxesValue: 28,
                      bottomAxesValue: 45,
                      rightAxesValue: 27),
                  TernaryPosition(
                      leftAxesValue: 28,
                      bottomAxesValue: 22,
                      rightAxesValue: 50),
                  TernaryPosition(
                      leftAxesValue: 5,
                      bottomAxesValue: 45,
                      rightAxesValue: 50),
                  TernaryPosition(
                      leftAxesValue: 5,
                      bottomAxesValue: 53,
                      rightAxesValue: 42),
                  TernaryPosition(
                      leftAxesValue: 20,
                      bottomAxesValue: 53,
                      rightAxesValue: 32),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
