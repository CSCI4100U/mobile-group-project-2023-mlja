import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:life_balance_plus/data/database_provider.dart';
import 'package:life_balance_plus/data/model/workout_plan.dart';

class ExerciseControl {
  Future addDummyData() async {
    // Test list of exercises
    List<ExercisePlan> exList = [
      ExercisePlan(name: 'Push-up', sets: 4),
      ExercisePlan(name: 'Pull-up', sets: 8),
      ExercisePlan(name: 'Sit-up', sets: 15),
      ExercisePlan(name: 'Squat', sets: 10),
      ExercisePlan(name: 'Biceps Curl', sets: 15),
    ];

    addExercisesMult(exList);
  }

  Future<List<ExercisePlan>> getAllExercises() async {
    final Database db = await DatabaseProvider.instance.database;
    final List maps = await db.query('exercises');
    List<ExercisePlan> result = [];
    for (int i = 0; i < maps.length; i++) {
      result.add(ExercisePlan.fromMap(maps[i]));
    }
    return result;
  }

  Future<int> addExercise(ExercisePlan ex) async {
    final Database db = await DatabaseProvider.instance.database;
    return db.insert('exercises', ex.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future addExercisesMult(List<ExercisePlan> exs) async {
    final Database db = await DatabaseProvider.instance.database;
    exs.forEach((ex) {
      db.insert('exercises', ex.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  Future updateExercise(ExercisePlan ex) async {
    final Database db = await DatabaseProvider.instance.database;
    return db
        .update('exercises', ex.toMap(), where: 'id = ?', whereArgs: [ex.id]);
  }

  Future deleteExercise(int id) async {
    final Database db = await DatabaseProvider.instance.database;
    await db.delete('exercises', where: 'id = ?', whereArgs: [id]);
  }
}
