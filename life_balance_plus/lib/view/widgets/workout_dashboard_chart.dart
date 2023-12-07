import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WorkoutDashboardChart extends StatelessWidget {
  const WorkoutDashboardChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Workout Distribution",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: _generateSections(),
                  borderData: FlBorderData(show: false),
                  centerSpaceRadius: 0,
                  sectionsSpace: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _generateSections() {
    return [
      PieChartSectionData(
        color: Colors.blue,
        value: 33.3, // Replace with actual distribution value for Push Day
        title: 'Push Day',
        radius: 100,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      ),
      PieChartSectionData(
        color: Colors.orange,
        value: 33.3, // Replace with actual distribution value for Pull Day
        title: 'Pull Day',
        radius: 100,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      ),
      PieChartSectionData(
        color: Colors.green,
        value: 33.4, // Replace with actual distribution value for Leg Day
        title: 'Leg Day',
        radius: 100,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      ),
    ];
  }
}
