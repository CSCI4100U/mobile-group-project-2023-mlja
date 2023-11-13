import 'package:flutter/material.dart';

class WorkoutDashboardWorkoutCard extends StatelessWidget {
  const WorkoutDashboardWorkoutCard({super.key});

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
              ],
            ),
            const SizedBox(height: 6),
            const Text("Push Day"),
            const SizedBox(height: 10),
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
            const Divider(),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Workout 1",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  Text(
                    "3 Sets",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Workout 2",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  Text(
                    "3 Sets",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Workout 3",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  Text(
                    "4 Sets",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                label: const Text("Start Workout"),
                icon: const Icon(Icons.play_circle),
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
