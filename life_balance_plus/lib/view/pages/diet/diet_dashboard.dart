import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DietDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          SizedBox(height: 16),
          _buildSummaryCards(),
          SizedBox(height: 16),
          _buildMacroChart(),
          SizedBox(height: 16),
          _buildNutrientDetails(),
          SizedBox(height: 16),
          _buildMealPlan(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Diet Dashboard',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Track your nutrition and stay healthy!',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSummaryCard(
            'Total Calories', '2000 kcal', Icons.local_fire_department),
        _buildSummaryCard('Proteins', '200 g', Icons.food_bank),
        _buildSummaryCard('Carbs', '350 g', Icons.local_dining),
        _buildSummaryCard('Fats', '80 g', Icons.emoji_food_beverage),
      ],
    );
  }

  Widget _buildSummaryCard(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, size: 36, color: Colors.white),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 16, color: Colors.white)),
          SizedBox(height: 8),
          Text(value,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildMacroChart() {
    return Container(
      height: 250,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: BarChart(
        BarChartData(
          barGroups: _buildMacroBarGroups(),
          titlesData: _buildTitlesData(),
          borderData: FlBorderData(
            show: true,
            border: Border(
              bottom: BorderSide(color: Colors.grey, width: 0.5),
              right: BorderSide(color: Colors.grey, width: 0.5),
            ),
          ),
          gridData: FlGridData(
            show: true,
            horizontalInterval: 100,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey,
                strokeWidth: 0.5,
              );
            },
          ),
        ),
      ),
    );
  }

  FlTitlesData _buildTitlesData() {
    return FlTitlesData(
      leftTitles: SideTitles(
        showTitles: false,
        interval: 100,
        getTitles: (value) {
          return value.toInt().toString();
        },
      ),
      bottomTitles: SideTitles(
        showTitles: true,
        getTitles: (value) {
          switch (value.toInt()) {
            case 0:
              return 'Proteins';
            case 1:
              return 'Carbs';
            case 2:
              return 'Fats';
            default:
              return '';
          }
        },
      ),
    );
  }

  List<BarChartGroupData> _buildMacroBarGroups() {
    return [
      _buildBarChartGroupData(0, 200, 'Proteins', Colors.green),
      _buildBarChartGroupData(1, 350, 'Carbs', Colors.orange),
      _buildBarChartGroupData(2, 80, 'Fats', Colors.red),
    ];
  }

  BarChartGroupData _buildBarChartGroupData(
      int x, double y, String label, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: y,
          colors: [color],
        ),
      ],
    );
  }

  Widget _buildNutrientDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nutrient Details',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        _buildNutrientRow('Proteins', '200 g', Colors.green),
        _buildNutrientRow('Carbs', '350 g', Colors.orange),
        _buildNutrientRow('Fats', '80 g', Colors.red),
      ],
    );
  }

  Widget _buildNutrientRow(String nutrient, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(nutrient, style: TextStyle(fontSize: 16, color: Colors.grey)),
        Text(value,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }

  Widget _buildMealPlan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s Meal Plan',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        _buildMealItem('Breakfast', 'Oatmeal with berries'),
        _buildMealItem('Lunch', 'Grilled chicken salad'),
        _buildMealItem('Dinner', 'Salmon with quinoa'),
      ],
    );
  }

  Widget _buildMealItem(String mealTime, String mealName) {
    return ListTile(
      title: Text(mealTime,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      subtitle: Text(mealName, style: TextStyle(fontSize: 16)),
      leading: Icon(Icons.restaurant_menu, size: 36, color: Colors.blue),
    );
  }
}
