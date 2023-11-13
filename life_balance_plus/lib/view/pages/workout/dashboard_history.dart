import 'package:flutter/material.dart';
import 'package:life_balance_plus/view/widgets/workout_dashboard_history_card.dart';

class DashboardHistory extends StatelessWidget {
  const DashboardHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Workout History',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 26),
            WorkoutDashboardHistoryCard(
                title: 'Back Day',
                date: DateTime(2023, 9, 21),
                muscleGroup: 'Back'),
            const SizedBox(height: 16),
            WorkoutDashboardHistoryCard(
                title: 'Chest Day',
                date: DateTime(2023, 9, 12),
                muscleGroup: 'Chest'),
          ],
        ),
      ),
    );
  }
}
