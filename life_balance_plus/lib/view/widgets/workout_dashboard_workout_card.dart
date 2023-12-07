import 'package:flutter/material.dart';

class WorkoutDashboardWorkoutCard extends StatelessWidget {
  const WorkoutDashboardWorkoutCard({Key? key});

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
                _buildExerciseTag(context, "Chest"),
                const SizedBox(width: 8),
                _buildExerciseTag(context, "Shoulders"),
                const SizedBox(width: 8),
                _buildExerciseTag(context, "Triceps"),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            _buildWorkoutDetails(context, "Workout 1", "3 Sets", "Bench Press",
                "10 reps", "50 kg"),
            const Divider(),
            _buildWorkoutDetails(context, "Workout 2", "3 Sets",
                "Shoulder Press", "12 reps", "20 kg"),
            const Divider(),
            _buildWorkoutDetails(context, "Workout 3", "4 Sets", "Tricep Dips",
                "15 reps", "Body Weight"),
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

  Widget _buildExerciseTag(BuildContext context, String exerciseName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: const Color.fromARGB(60, 158, 158, 158),
      ),
      child: Text(exerciseName),
    );
  }

  Widget _buildWorkoutDetails(
    BuildContext context,
    String workoutName,
    String setsAndReps,
    String exerciseName,
    String reps,
    String weight,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                workoutName,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
              Text(
                setsAndReps,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                exerciseName,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                "$reps • $weight",
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
