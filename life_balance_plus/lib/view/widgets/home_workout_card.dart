import 'package:flutter/material.dart';
import 'package:life_balance_plus/view/pages/workout/workout_session_page.dart';

class HomeWorkoutCard extends StatelessWidget {
  final String workoutName;
  const HomeWorkoutCard({Key? key, required this.workoutName})
      : super(key: key);

  // const HomeWorkoutCard({super.key, required this.workoutName});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 22, right: 16, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's Workout",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
                Text(
                  workoutName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text("Note: Get on Tren"),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color.fromARGB(60, 158, 158, 158),
                  ),
                  child: Text("Chest"),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color.fromARGB(60, 158, 158, 158),
                  ),
                  child: const Text("Shoulders"),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color.fromARGB(60, 158, 158, 158),
                  ),
                  child: const Text("Triceps"),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              label: const Text("Start Workout"),
              icon: const Icon(Icons.play_circle),
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const WorkoutSessionPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
