import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeRunCard extends StatelessWidget {
  const HomeRunCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Running Data',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              child: BarChart(
                BarChartData(
                  // Your bar chart data and configurations go here
                  // Example: BarData(...),
                  titlesData: FlTitlesData(
                    leftTitles: SideTitles(showTitles: true),
                    bottomTitles: SideTitles(showTitles: true),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border:
                        Border.all(color: const Color(0xff37434d), width: 1),
                  ),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          y: 8,
                          width: 16,
                          colors: [Colors.blue],
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          y: 10,
                          width: 16,
                          colors: [Colors.green],
                        ),
                      ],
                    ),
                    // Add more BarChartGroupData for additional bars
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
