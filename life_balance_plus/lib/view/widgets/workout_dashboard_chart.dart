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
                  centerSpaceRadius: 40,
                  sectionsSpace: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _generateSections() {
    return List.generate(
      3, // Replace with the number of workout categories
      (index) {
        final isTouched = index == 0; // Highlight the first section if needed

        return PieChartSectionData(
          color: _getRandomColor(), // You can customize colors as needed
          value: 30.0, // Replace with actual distribution values
          title: 'Category $index', // Replace with actual category names
          radius: isTouched ? 80 : 60,
          titleStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
          ),
        );
      },
    );
  }

  Color _getRandomColor() {
    // Replace with your logic to generate different colors
    return Color.fromARGB(
      255,
      100 +
          (50 * (DateTime.now().microsecondsSinceEpoch % 1000) / 1000).toInt(),
      150 +
          (50 * (DateTime.now().microsecondsSinceEpoch % 1000) / 1000).toInt(),
      200 +
          (55 * (DateTime.now().microsecondsSinceEpoch % 1000) / 1000).toInt(),
    );
  }
}
