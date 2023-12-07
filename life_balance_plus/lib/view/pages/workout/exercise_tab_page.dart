import 'package:flutter/material.dart';
import 'package:life_balance_plus/data/model/workout_plan.dart';
import 'package:life_balance_plus/data/model/exercise.dart';
import 'package:life_balance_plus/control/workouts_control.dart';
import 'package:life_balance_plus/view/pages/workout/add_exercise_page.dart';

class ExerciseTabPage extends StatefulWidget {
  const ExerciseTabPage({super.key});

  @override
  State<ExerciseTabPage> createState() => _ExerciseTabPageState();
}

class _ExerciseTabPageState extends State<ExerciseTabPage> {
  List<ExerciseSet> exerciseList = [];
  List<ExerciseSet> filteredList = [];

  Future<void> _loadExercises() async {
    var temp = await WorkoutControl().getExerciseSets();
    setState(() {
      exerciseList = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    // TESTING: Uncomment this the first time you run to add some exercises to the local db
    WorkoutControl().addDummyData();
    _loadExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Add Exercise'),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddExercisePage(),
              fullscreenDialog: true,
            ),
          );
        },
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  'Filter:',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      // TODO: Implement filter functionality & iteratively build filter chips
                      FilterChip(
                        label: const Text('All'),
                        selected: true,
                        onSelected: (value) {},
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Favorites'),
                        selected: false,
                        onSelected: (value) {},
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Chest'),
                        selected: false,
                        onSelected: (value) {},
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Back'),
                        selected: false,
                        onSelected: (value) {},
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Legs'),
                        selected: false,
                        onSelected: (value) {},
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Arms'),
                        selected: false,
                        onSelected: (value) {},
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Shoulders'),
                        selected: false,
                        onSelected: (value) {},
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Core'),
                        selected: false,
                        onSelected: (value) {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Scrollbar(
              child: ListView.builder(
                itemCount: exerciseList.length,
                itemBuilder: (context, index) {
                  final exercise = exerciseList[index];
                  return ListTile(
                    leading: const Center(
                      heightFactor: 2,
                      widthFactor: 1,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white38,
                        radius: 16,
                        child: Icon(Icons.fitness_center, size: 20),
                      ),
                    ),
                    title: Text(exercise.name),
                    subtitle: Text(exercise.muscleGroups.join(' | ')),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
