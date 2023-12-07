import 'package:flutter/material.dart';
import 'package:life_balance_plus/view/widgets/workout_dashboard_chart.dart';
import 'package:life_balance_plus/view/widgets/workout_dashboard_workout_card.dart';

/// A widget representing the gym dashboard.
class DashboardGym extends StatelessWidget {
  const DashboardGym({Key? key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome message for the gym dashboard
            Center(
              child: Text(
                'Welcome Back to the Gym Zone!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 16),

            // Workout card widget displaying today's workout details
            const WorkoutDashboardWorkoutCard(),
            const SizedBox(height: 16),

            // Workout chart widget displaying workout distribution
            const WorkoutDashboardChart(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
