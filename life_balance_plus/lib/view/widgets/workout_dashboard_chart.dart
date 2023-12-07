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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem(context, Colors.blue, 'Push Day'),
                _buildLegendItem(context, Colors.orange, 'Pull Day'),
                _buildLegendItem(context, Colors.green, 'Leg Day'),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: _generateSections(),
                  borderData: FlBorderData(show: false),
                  centerSpaceRadius: 30,
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
        value: 40, // Replace with actual distribution value for Push Day
        radius: 70,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      ),
      PieChartSectionData(
        color: Colors.orange,
        value: 35, // Replace with actual distribution value for Pull Day
        radius: 70,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      ),
      PieChartSectionData(
        color: Colors.green,
        value: 25, // Replace with actual distribution value for Leg Day
        radius: 70,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      ),
    ];
  }

  Widget _buildLegendItem(BuildContext context, Color color, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
    );
  }
}
