import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pretty_charts/pretty_charts.dart';

class CategoryTreeMapChartScreen extends StatelessWidget {
  const CategoryTreeMapChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox.expand(
        child: TreeMapChart(
          onGenerateSelectedLabel: (data) {
            final valueInMillions =
                NumberFormat.compactLong().format(data.value);
            return "${data.name} : $valueInMillions";
          },
          data: [
            TreeMapChartData.category(
              name: 'Asia',
              children: [
                TreeMapChartData(name: 'China', value: 1444216107),
                TreeMapChartData(name: 'India', value: 1393409038),
                TreeMapChartData(name: 'Indonesia', value: 276361783),
                TreeMapChartData(name: 'Pakistan', value: 225199937),
                TreeMapChartData(name: 'Bangladesh', value: 166303498),
                TreeMapChartData(name: 'Japan', value: 126050804),
                TreeMapChartData(name: 'Philippines', value: 112156843),
                TreeMapChartData(name: 'Vietnam', value: 100695847),
                TreeMapChartData(name: 'Iran', value: 85193735),
                TreeMapChartData(name: 'Turkey', value: 85042715),
                TreeMapChartData(name: 'Thailand', value: 69830779),
                TreeMapChartData(name: 'South Korea', value: 51276977),
                TreeMapChartData(name: 'Iraq', value: 41701513),
                // Add more Asian countries here
              ],
            ),
            TreeMapChartData.category(
              name: 'Africa',
              children: [
                TreeMapChartData(name: 'Nigeria', value: 211400708),
                TreeMapChartData(name: 'Ethiopia', value: 120977046),
                TreeMapChartData(name: 'Egypt', value: 104258327),
                TreeMapChartData(name: 'DR Congo', value: 91377701),
                TreeMapChartData(name: 'Tanzania', value: 64006299),
                TreeMapChartData(name: 'South Africa', value: 59622350),
                TreeMapChartData(name: 'Kenya', value: 54762938),
                TreeMapChartData(name: 'Uganda', value: 46400600),
                TreeMapChartData(name: 'Algeria', value: 43851044),
                TreeMapChartData(name: 'Sudan', value: 44209235),
                TreeMapChartData(name: 'Morocco', value: 37267856),
                TreeMapChartData(name: 'Angola', value: 32866272),
                TreeMapChartData(name: 'Mozambique', value: 32709396),
                TreeMapChartData(name: 'Ghana', value: 31072940),
                TreeMapChartData(name: 'Madagascar', value: 27691019),
                TreeMapChartData(name: 'Cameroon', value: 27499990),
                TreeMapChartData(name: 'Côte d\'Ivoire', value: 26378275),
                TreeMapChartData(name: 'Niger', value: 24535296),
                TreeMapChartData(name: 'Burkina Faso', value: 21178674),
                TreeMapChartData(name: 'Mali', value: 20836650),
              ],
            ),
            TreeMapChartData.category(
              name: 'Europe',
              children: [
                TreeMapChartData(name: 'Russia', value: 145912025),
                TreeMapChartData(name: 'Germany', value: 83900473),
                TreeMapChartData(name: 'United Kingdom', value: 67886011),
                TreeMapChartData(name: 'France', value: 65273511),
                TreeMapChartData(name: 'Italy', value: 60550075),
                TreeMapChartData(name: 'Spain', value: 46745289),
                TreeMapChartData(name: 'Ukraine', value: 43733762),
                TreeMapChartData(name: 'Poland', value: 37846611),
                TreeMapChartData(name: 'Romania', value: 19401658),
                TreeMapChartData(name: 'Netherlands', value: 17173030),
                TreeMapChartData(name: 'Belgium', value: 11589616),
                TreeMapChartData(name: 'Greece', value: 10423054),
                TreeMapChartData(name: 'Czech Republic', value: 10708981),
                TreeMapChartData(name: 'Portugal', value: 10196709),
                TreeMapChartData(name: 'Sweden', value: 10160169),
                TreeMapChartData(name: 'Hungary', value: 9660351),
                TreeMapChartData(name: 'Belarus', value: 9449323),
                TreeMapChartData(name: 'Austria', value: 9055010),
                TreeMapChartData(name: 'Switzerland', value: 8715492),
                TreeMapChartData(name: 'Bulgaria', value: 6975761),
              ],
            ),
            TreeMapChartData.category(
              name: 'North America',
              children: [
                TreeMapChartData(name: 'United States', value: 332915073),
                TreeMapChartData(name: 'Mexico', value: 130262216),
                TreeMapChartData(name: 'Canada', value: 37742154),
                TreeMapChartData(name: 'Guatemala', value: 17915568),
                TreeMapChartData(name: 'Cuba', value: 11326616),
                TreeMapChartData(name: 'Haiti', value: 11402528),
                TreeMapChartData(name: 'Dominican Republic', value: 10957980),
                TreeMapChartData(name: 'Honduras', value: 10018307),
                TreeMapChartData(name: 'El Salvador', value: 6597054),
                TreeMapChartData(name: 'Nicaragua', value: 6740521),
                TreeMapChartData(name: 'Costa Rica', value: 5264479),
                TreeMapChartData(name: 'Panama', value: 4544756),
                TreeMapChartData(name: 'Jamaica', value: 2961161),
                TreeMapChartData(name: 'Trinidad and Tobago', value: 1394973),
                TreeMapChartData(name: 'Bahamas', value: 396914),
                // Add more North American countries here
              ],
            ),
            TreeMapChartData.category(
              name: 'South America',
              children: [
                TreeMapChartData(name: 'Brazil', value: 213993437),
                TreeMapChartData(name: 'Argentina', value: 45723553),
                TreeMapChartData(name: 'Colombia', value: 50976248),
                TreeMapChartData(name: 'Venezuela', value: 28435940),
                TreeMapChartData(name: 'Peru', value: 33103215),
                TreeMapChartData(name: 'Chile', value: 19116201),
                TreeMapChartData(name: 'Ecuador', value: 17794929),
                TreeMapChartData(name: 'Bolivia', value: 11890781),
                TreeMapChartData(name: 'Paraguay', value: 7152703),
                TreeMapChartData(name: 'Uruguay', value: 3475842),
                TreeMapChartData(name: 'Guyana', value: 790326),
                TreeMapChartData(name: 'Suriname', value: 586632),
                TreeMapChartData(name: 'French Guiana', value: 298682),
                TreeMapChartData(name: 'Falkland Islands', value: 3480),
                // Add more South American countries here
              ],
            ),
            TreeMapChartData.category(
              name: 'Oceania',
              children: [
                TreeMapChartData(name: 'Australia', value: 25690614),
                TreeMapChartData(name: 'New Zealand', value: 4822233),
                TreeMapChartData(name: 'Papua New Guinea', value: 9205200),
                TreeMapChartData(name: 'Fiji', value: 896445),
                TreeMapChartData(name: 'Solomon Islands', value: 716943),
                TreeMapChartData(name: 'Vanuatu', value: 321506),
                TreeMapChartData(name: 'New Caledonia', value: 292074),
                TreeMapChartData(name: 'Samoa', value: 198414),
                TreeMapChartData(name: 'Guam', value: 167245),
                TreeMapChartData(name: 'Kiribati', value: 120428),
                TreeMapChartData(name: 'Tonga', value: 109008),
                TreeMapChartData(
                    name: 'Federated States of Micronesia', value: 116254),
                TreeMapChartData(name: 'Marshall Islands', value: 59190),
                TreeMapChartData(name: 'Palau', value: 18109),
                TreeMapChartData(name: 'Tuvalu', value: 11646),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
