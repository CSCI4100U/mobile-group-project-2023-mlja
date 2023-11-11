import 'package:sqflite/sqflite.dart';
import 'dart:async';
import '../data/database_provider.dart';
import '../model/exercise.dart';

class ExerciseControl {

  Future addDummyData() async {
    // Test list of exercises
    List<Exercise> exList = [
      Exercise(name: 'Push-up', sets: 4),
      Exercise(name: 'Pull-up', sets: 8),
      Exercise(name: 'Sit-up', sets: 15),
      Exercise(name: 'Squat', sets: 10),
      Exercise(name: 'Biceps Curl', sets: 15),
    ];

    addExercisesMult(exList);
  }

  Future<List<Exercise>> getAllExercises() async {
    final db = await DatabaseDriver.init();
    final List maps = await db.query('exercises');
    List<Exercise> result = [];
    for (int i=0; i<maps.length; i++) {
      result.add(Exercise.fromMap(maps[i]));
    }
    return result;
  }

  Future<int> addExercise(Exercise ex) async {
    final db = await DatabaseDriver.init();
    return db.insert(
      'exercises',
      ex.toMap(),
      conflicAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future addExercisesMult(List<Exercise> exs) async {
    final db = await DatabaseDriver.init();
    exs.forEach((ex) {
      db.insert(
        'exercises',
        ex.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
      );
    });
  }

  Future updateExercise(Exercise ex) async {
    final db = await DatabaseDriver.init();
    return db.update(
      'exercises',
      ex.toMap(),
      where: 'id = ?',
      whereArgs: [ex.id]
    );
  }

  Future deleteExercise(int id) async {
    final db = await DatabaseDriver.init();
    await db.delete(
      'exercises',
      where: 'id = ?',
      whereArgs: [id]
    );
  }
}