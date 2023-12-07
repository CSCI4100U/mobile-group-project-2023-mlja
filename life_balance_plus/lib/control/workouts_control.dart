import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_balance_plus/data/enums/equipment.dart';
import 'package:life_balance_plus/data/enums/muscle_group.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:life_balance_plus/data/database_provider.dart';
import 'package:life_balance_plus/data/model/exercise.dart';
import 'package:life_balance_plus/data/model/workout_plan.dart';
import 'package:life_balance_plus/data/model/session.dart';

// A lot of repeated code here. There might be a away to "generic-fy" everything.

class WorkoutControl {
  final userId = Session.instance.account!.firestoreId;

  Future<void> addDummyData() async {
    final WorkoutPlan wp = WorkoutPlan(
      startDate: DateTime.now(),
      title: "Test Workout Plan",
      type: WorkoutPlanType.custom,
      sessions: [],
    );
    await addWorkoutPlan(wp);

    final WorkoutSession ws = WorkoutSession(
      date: DateTime.now(),
      planId: wp.planId!,
      exercises: [],
    );

    await addWorkoutSession(ws);
    wp.addSession(ws);

    final ExerciseSet es = ExerciseSet(
      name: 'Test ExerciseSet',
      sessionId: ws.sessionId!,
      muscleGroups: [MuscleGroup.other],
      requiredEquipment: [Equipment.other],
    );

    await addExerciseSet(es);
    ws.addExercise(es);
  }

  // WorkoutPlan control

  Future<List<WorkoutPlan>> getWorkoutPlans() async {
    final Database db = await DatabaseProvider.instance.database;
    List<WorkoutPlan> result;
    final List localData = await db.query('workout_plans');
    if (localData.isNotEmpty) {
      result = localData.map((wp) {
        return WorkoutPlan.fromMap(wp);
      }).toList();
    } else {
      // Query firestore if local db is empty

      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('workout_plans')
              .where('userId', isEqualTo: Session.instance.account!.firestoreId)
              .get();
      final documents = querySnapshot.docs;

      List<Map<String, dynamic>> remoteData =
          documents.map((doc) => doc.data()).toList();

      result = remoteData.map((wp) {
        return WorkoutPlan.fromMap(wp);
      }).toList();
    }

    return result;
  }

  Future<void> addWorkoutPlan(WorkoutPlan wp) async {
    final Database db = await DatabaseProvider.instance.database;
    wp.planId = await db.insert('workout_plans', wp.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    _addCloudWorkoutPlan(wp);
  }

  Future<void> _addCloudWorkoutPlan(WorkoutPlan wp) async {
    final ref = FirebaseFirestore.instance.collection('workout_plans').doc();
    try {
      ref.set({
        ...wp.toMap(),
        'userId': userId,
      });
    } catch (e) {
      print('Error adding WorkoutPlan to Firestore: $e');
    }
  }

  Future<void> updateWorkoutPlan(WorkoutPlan wp) async {
    final Database db = await DatabaseProvider.instance.database;
    db.update('workout_plans', wp.toMap());
    _updateCloudWorkoutPlan(wp);
  }

  Future<void> _updateCloudWorkoutPlan(WorkoutPlan wp) async {
    FirebaseFirestore.instance
        .collection('workout_plans')
        .doc(wp.firestoreId)
        .update(wp.toMap());
  }

  Future<void> deleteWorkoutPlan(WorkoutPlan wp) async {
    final Database db = await DatabaseProvider.instance.database;
    await db
        .delete('workout_plans', where: 'planId = ?', whereArgs: [wp.planId]);
    _deleteCloudWorkoutPlan(wp);
  }

  Future<void> _deleteCloudWorkoutPlan(WorkoutPlan wp) async {
    FirebaseFirestore.instance
        .collection('workout_plans')
        .doc(wp.firestoreId)
        .delete()
        .then((_) {
      print('WorkoutPlan deleted from Firestore: $wp');
    }).catchError((e) {
      print('Error deleting WorkoutPlan from Firestore: $e');
    });
  }

  // ---------------------------------------------------------------

  // WorkoutSession control

  Future<List<WorkoutSession>> getWorkoutSessions() async {
    final Database db = await DatabaseProvider.instance.database;
    List<WorkoutSession> result;
    final List localData = await db.query('workout_sessions');

    if (localData.isNotEmpty) {
      result = localData.map((ws) {
        return WorkoutSession.fromMap(ws);
      }).toList();
    } else {
      // Query firestore if local db is empty

      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('workout_sessions')
              .where('userId', isEqualTo: Session.instance.account!.firestoreId)
              .get();
      final documents = querySnapshot.docs;

      List<Map<String, dynamic>> remoteData =
          documents.map((doc) => doc.data()).toList();

      result = remoteData.map((ws) {
        return WorkoutSession.fromMap(ws);
      }).toList();
    }

    return result;
  }

  Future<void> addWorkoutSession(WorkoutSession ws) async {
    final Database db = await DatabaseProvider.instance.database;
    ws.sessionId = await db.insert('workout_sessions', ws.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    _addCloudWorkoutSession(ws);
  }

  Future<void> _addCloudWorkoutSession(WorkoutSession ws) async {
    final ref = FirebaseFirestore.instance.collection('workout_sessions').doc();
    try {
      ref.set({
        ...ws.toMap(),
        'userId': userId,
      });
    } catch (e) {
      print('Error adding WorkoutSession to Firestore: $e');
    }
  }

  Future<void> updateWorkoutSession(WorkoutSession ws) async {
    final Database db = await DatabaseProvider.instance.database;
    db.update('workout_sessions', ws.toMap());
    _updateCloudWorkoutSession(ws);
  }

  Future<void> _updateCloudWorkoutSession(WorkoutSession ws) async {
    FirebaseFirestore.instance
        .collection('workout_sessions')
        .doc(ws.firestoreId)
        .update(ws.toMap());
  }

  Future<void> deleteWorkoutSession(WorkoutSession ws) async {
    final Database db = await DatabaseProvider.instance.database;
    await db.delete('workout_sessions',
        where: 'sessionId = ?', whereArgs: [ws.sessionId]);
    _deleteCloudWorkoutSession(ws);
  }

  Future _deleteCloudWorkoutSession(WorkoutSession ws) async {
    FirebaseFirestore.instance
        .collection('workout_sessions')
        .doc(ws.firestoreId)
        .delete()
        .then((_) {
      print('WorkoutSession deleted from Firestore: $ws');
    }).catchError((e) {
      print('Error deleting WorkoutSession from Firestore: $e');
    });
  }

  // ---------------------------------------------------------------

  // ExerciseSet control

  Future<List<ExerciseSet>> getExerciseSets() async {
    final Database db = await DatabaseProvider.instance.database;
    List<ExerciseSet> result = [];
    final List localData = await db.query('exercise_sets');

    if (localData.isNotEmpty) {
      result = localData.map((es) {
        return ExerciseSet.fromMap(es);
      }).toList();
    } else {
      // Query firestore if local db is empty

      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('exercise_sets')
              .where('userId', isEqualTo: Session.instance.account!.firestoreId)
              .get();
      final documents = querySnapshot.docs;

      List<Map<String, dynamic>> remoteData =
          documents.map((doc) => doc.data()).toList();

      result = remoteData.map((es) {
        return ExerciseSet.fromMap(es);
      }).toList();
    }

    return result;
  }

  Future<void> addExerciseSet(ExerciseSet es) async {
    final Database db = await DatabaseProvider.instance.database;
    await db.insert('exercise_sets', es.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    _addCloudExerciseSets(es);
  }

  Future _addCloudExerciseSets(ExerciseSet es) async {
    final ref = FirebaseFirestore.instance.collection('exercise_sets').doc();
    try {
      ref.set({
        ...es.toMap(),
        'userId': userId,
      });
    } catch (e) {
      print('Error adding ExerciseSet to Firestore: $e');
    }
  }

  Future<void> updateExerciseSets(ExerciseSet es) async {
    final Database db = await DatabaseProvider.instance.database;
    db.update('exercise_sets', es.toMap());
    _updateCloudExerciseSet(es);
  }

  Future<void> _updateCloudExerciseSet(ExerciseSet es) async {
    FirebaseFirestore.instance
        .collection('exercise_sets')
        .doc(es.firestoreId)
        .update(es.toMap());
  }

  Future<void> deleteExerciseSet(ExerciseSet es) async {
    final Database db = await DatabaseProvider.instance.database;
    await db.delete('exercise_sets', where: 'id = ?', whereArgs: [es.id]);

    _deleteCloudExerciseSet(es);
  }

  Future _deleteCloudExerciseSet(ExerciseSet es) async {
    FirebaseFirestore.instance
        .collection('exercise_sets')
        .doc(es.firestoreId)
        .delete()
        .then((_) {
      print('ExerciseSet deleted from Firestore: $es');
    }).catchError((e) {
      print('Error deleting ExerciseSet from Firestore: $e');
    });
  }
}
