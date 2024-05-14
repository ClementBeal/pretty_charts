import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pretty_charts/pretty_charts.dart';

@RoutePage()
class BasicTreeMapChartScreen extends StatelessWidget {
  const BasicTreeMapChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: TreeMapChart(
        onGenerateSelectedLabel: (data) {
          final valueInMillions = NumberFormat.compactLong().format(data.value);
          return "${data.name} : $valueInMillions";
        },
        data: [
          TreeMapChartData(name: 'China', value: 1444216107),
          TreeMapChartData(name: 'India', value: 1393409038),
          TreeMapChartData(name: 'United States', value: 332915073),
          TreeMapChartData(name: 'Indonesia', value: 276361783),
          TreeMapChartData(name: 'Pakistan', value: 225199937),
          TreeMapChartData(name: 'Brazil', value: 213993437),
          TreeMapChartData(name: 'Nigeria', value: 211400708),
          TreeMapChartData(name: 'Bangladesh', value: 166303498),
          TreeMapChartData(name: 'Russia', value: 145912025),
          TreeMapChartData(name: 'Mexico', value: 130262216),
          TreeMapChartData(name: 'Japan', value: 126050804),
          TreeMapChartData(name: 'Ethiopia', value: 120977046),
          TreeMapChartData(name: 'Philippines', value: 112156843),
          TreeMapChartData(name: 'Egypt', value: 104258327),
          TreeMapChartData(name: 'Vietnam', value: 100695847),
          TreeMapChartData(name: 'DR Congo', value: 91377701),
          TreeMapChartData(name: 'Turkey', value: 85042715),
          TreeMapChartData(name: 'Iran', value: 85193735),
          TreeMapChartData(name: 'Germany', value: 83900473),
          TreeMapChartData(name: 'Thailand', value: 69830779),
          TreeMapChartData(name: 'United Kingdom', value: 67886011),
          TreeMapChartData(name: 'France', value: 65273511),
          TreeMapChartData(name: 'Italy', value: 60550075),
          TreeMapChartData(name: 'Tanzania', value: 64006299),
          TreeMapChartData(name: 'South Africa', value: 59622350),
          TreeMapChartData(name: 'Myanmar', value: 54817919),
          TreeMapChartData(name: 'Kenya', value: 54762938),
          TreeMapChartData(name: 'South Korea', value: 51276977),
          TreeMapChartData(name: 'Colombia', value: 50976248),
          TreeMapChartData(name: 'Spain', value: 46745289),
          TreeMapChartData(name: 'Uganda', value: 46400600),
          TreeMapChartData(name: 'Argentina', value: 45723553),
          TreeMapChartData(name: 'Algeria', value: 43851044),
          TreeMapChartData(name: 'Sudan', value: 44209235),
          TreeMapChartData(name: 'Ukraine', value: 43733762),
          TreeMapChartData(name: 'Iraq', value: 41701513),
          TreeMapChartData(name: 'Afghanistan', value: 40091280),
          TreeMapChartData(name: 'Poland', value: 37846611),
          TreeMapChartData(name: 'Canada', value: 37742154),
          TreeMapChartData(name: 'Morocco', value: 37267856),
          TreeMapChartData(name: 'Saudi Arabia', value: 34905908),
          TreeMapChartData(name: 'Uzbekistan', value: 34096198),
          TreeMapChartData(name: 'Peru', value: 33103215),
          TreeMapChartData(name: 'Angola', value: 32866272),
          TreeMapChartData(name: 'Malaysia', value: 32782964),
          TreeMapChartData(name: 'Mozambique', value: 32709396),
          TreeMapChartData(name: 'Ghana', value: 31072940),
          TreeMapChartData(name: 'Yemen', value: 29825968),
          TreeMapChartData(name: 'Nepal', value: 29609623),
          TreeMapChartData(name: 'Venezuela', value: 28435940),
          TreeMapChartData(name: 'Madagascar', value: 27691019),
          TreeMapChartData(name: 'Cameroon', value: 27499990),
          TreeMapChartData(name: 'Côte d\'Ivoire', value: 26378275),
          TreeMapChartData(name: 'North Korea', value: 25778816),
          TreeMapChartData(name: 'Australia', value: 25690614),
          TreeMapChartData(name: 'Taiwan', value: 23527673),
          TreeMapChartData(name: 'Niger', value: 24535296),
          TreeMapChartData(name: 'Sri Lanka', value: 21803000),
          TreeMapChartData(name: 'Burkina Faso', value: 21178674),
          TreeMapChartData(name: 'Mali', value: 20836650),
          TreeMapChartData(name: 'Romania', value: 19401658),
          TreeMapChartData(name: 'Malawi', value: 19129952),
        ],
      ),
    );
  }
}
