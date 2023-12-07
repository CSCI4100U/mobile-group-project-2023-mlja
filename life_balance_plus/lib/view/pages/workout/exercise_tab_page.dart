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
  List<ExerciseSet> exs = [];

  Future<void> _loadExercises() async {
    final exs_ = await WorkoutControl().getExerciseSets();
    setState(() {
      exs = exs_;
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
      body: Center(
        child: ListView.builder(
          itemCount: exs.length,
          itemBuilder: (context, index) {
            final ex = exs[index];
            return ListTile(
              title: Text(ex.name),
              subtitle: Text('Sets: ${ex.sets}'),
            );
          },
        ),
      ),
    );
  }
}
