import 'package:flutter/material.dart';
import 'package:life_balance_plus/data/enums/muscle_group.dart';
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
  List<Exercise> exerciseList = [];
  List<Exercise> filteredList = [];
  String search = '';

  Future<void> _loadExercises() async {
    // load exercises from file
  }

  void _filterExercises(String value) {
    setState(() {
      search = value;
      filteredList = exerciseList
          .where((exercise) =>
              exercise.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Add Exercise'),
        onPressed: () {
          WorkoutControl().addDummyData();
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => const AddExercisePage(),
          //     fullscreenDialog: true,
          //   ),
          // );
        },
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: _filterExercises,
                          decoration: const InputDecoration(
                            hintText: 'Search exercises...',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    children: [
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
                      const SizedBox(width: 4),
                      ...MuscleGroup.values.map(
                        (muscleGroup) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: FilterChip(
                              label: Text(muscleGroup.string),
                              selected: false,
                              onSelected: (value) {},
                            ),
                          );
                        },
                      ).toList(),
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
                padding: const EdgeInsets.only(bottom: 40),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final exercise = filteredList[index];
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
                      subtitle: Text(exercise.muscleGroups
                          .map((muscleGroup) => muscleGroup.string)
                          .join('  |  '))
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
