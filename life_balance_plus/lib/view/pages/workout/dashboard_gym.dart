import 'package:flutter/material.dart';
import 'package:life_balance_plus/view/widgets/workout_dashboard_chart.dart';
import 'package:life_balance_plus/view/widgets/workout_dashboard_workout_card.dart';

class DashboardGym extends StatelessWidget {
  const DashboardGym({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hey John',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            const WorkoutDashboardWorkoutCard(),
            const SizedBox(height: 16),
            const WorkoutDashboardChart(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
