import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:life_balance_plus/data/model/fitness_logs.dart';
import 'package:life_balance_plus/data/database_provider.dart';
import 'package:life_balance_plus/data/model/workout_plan.dart';
import 'package:life_balance_plus/data/model/account.dart';
import 'package:life_balance_plus/data/model/exercise.dart';

import 'package:life_balance_plus/data/enums/equipment.dart';
import 'package:life_balance_plus/data/enums/muscle_group.dart';


class WorkoutControl {



  void addDummyData() {
    print('LOADING DUMMY DATA...');

    Exercise benchPress = Exercise(
      name: 'Bench Press',
      description: '',
      muscleGroups: [MuscleGroup.chest, MuscleGroup.triceps, MuscleGroup.shoulders],
      requiredEquipment: [Equipment.flatBench],
    );
    Exercise pushups = Exercise(
      name: 'Pushups',
      description: '',
      muscleGroups: [MuscleGroup.chest, MuscleGroup.triceps, MuscleGroup.shoulders],
      requiredEquipment: [],
    );
    Exercise pullups = Exercise(
      name: 'Pullups',
      description: '',
      muscleGroups: [MuscleGroup.lats, MuscleGroup.upperBack, MuscleGroup.biceps],
      requiredEquipment: [Equipment.pullUpBar],
    );
    Exercise latPulldowns = Exercise(
      name: 'Lat Pulldowns',
      description: '',
      muscleGroups: [MuscleGroup.lats, MuscleGroup.upperBack, MuscleGroup.biceps],
      requiredEquipment: [Equipment.specializedMachine],
    );
    Exercise running = Exercise(
      name: 'Running',
      description: ''
    );

    WorkoutPlan plan = WorkoutPlan(
      accountEmail: 'mitchell.nolte@ontariotechu.net',
      title: 'Push Pull Legs',
      type: WorkoutPlanType.hypertrophy,
      sessions: [
        [
          ExercisePlan(
            exercise: benchPress,
            sets: 3,
            repTarget: 10
          ),
          ExercisePlan(
            exercise: pushups,
            sets: 3,
            repTarget: 30
          )
        ],
        [], // Rest day
        [
          ExercisePlan(
            exercise: pullups,
            sets: 3,
            repTarget: 20
          ),
          ExercisePlan(
            exercise: latPulldowns,
            sets: 3,
            repTarget: 10
          )
        ]
      ]
    );

    List<SessionLog> sessions = [
      SessionLog(
        accountEmail: 'mitchell.nolte@ontariotechu.net',
        date: DateTime.now(),
        sets: [
          ResistanceSetLog(
            exercise: benchPress,
            reps: 10,
            weight: 135
          ),
          ResistanceSetLog(
            exercise: benchPress,
            reps: 8,
            weight: 135
          ),
          ResistanceSetLog(
            exercise: benchPress,
            reps: 10,
            weight: 125
          ),
          ResistanceSetLog(
            exercise: pushups,
            reps: 30,
          ),
          ResistanceSetLog(
            exercise: pushups,
            reps: 24,
          ),
          ResistanceSetLog(
            exercise: pushups,
            reps: 19,
          ),
        ]
      ),
      SessionLog(
        accountEmail: 'mitchell.nolte@ontariotechu.net',
        date: DateTime.now(),
        sets: [
          ResistanceSetLog(
            exercise: pullups,
            reps: 20,
          ),
          ResistanceSetLog(
            exercise: pullups,
            reps: 17,
          ),
          ResistanceSetLog(
            exercise: pullups,
            reps: 14,
          ),
          ResistanceSetLog(
            exercise: latPulldowns,
            reps: 10,
            weight: 150
          ),
          ResistanceSetLog(
            exercise: latPulldowns,
            reps: 10,
            weight: 145
          ),
          ResistanceSetLog(
            exercise: latPulldowns,
            reps: 9,
            weight: 140
          ),
          CardioSetLog(
            exercise: running,
            duration: 30,
            avgSpeed: 5
          )
        ]
      ),
    ];

    addWorkoutPlan(plan);
    sessions.forEach((log) => addSessionLog(log));
  }



  // ---------------------------------------------------------------
  // WorkoutPlan control

  Future<List<WorkoutPlan>> getWorkoutPlans(Account account) async {
    final Database db = await DatabaseProvider.instance.database;
    List<WorkoutPlan> result;
    final List localData = await db.query(
      'workout_plans',
      where: 'accountEmail = ?',
      whereArgs: [account.email]
    );
    if (localData.isNotEmpty) {
      result = localData.map((plan) {
        return WorkoutPlan.fromMap(plan);
      }).toList();
    }

    // Query firestore if local db is empty
    else {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
          .collection('workout_plans')
          .where('accountEmail', isEqualTo: account.email)
          .get();

      final documents = querySnapshot.docs;
      result = documents.map((doc) {
        Map<String, dynamic> map = doc.data();
        map['firestoreId'] = doc.id;
        return map;
      }).toList().map((plan) => WorkoutPlan.fromMap(plan)).toList();
    }
  
    return result;
  }

  Future<void> addWorkoutPlan(WorkoutPlan plan) async {
    final Database db = await DatabaseProvider.instance.database;
    plan.id = await db.insert(
      'workout_plans',
      plan.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
    _addCloudWorkoutPlan(plan);
  }

  void _addCloudWorkoutPlan(WorkoutPlan plan) {
    final ref = FirebaseFirestore.instance.collection('workout_plans').doc();
    try {
      ref.set(plan.toFirestoreMap());
      plan.firestoreId = ref.id;
      updateWorkoutPlan(plan, false);
    } catch (e) {
      print('Error adding WorkoutPlan to Firestore: $e');
    }
  }

  Future updateWorkoutPlan(WorkoutPlan plan, [bool updateCloud=true]) async {
    final Database db = await DatabaseProvider.instance.database;
    db.update(
      'workout_plans',
      plan.toMap(),
      where: 'id = ?',
      whereArgs: [plan.id]
    );
    if(updateCloud) _updateCloudWorkoutPlan(plan);
  }

  void _updateCloudWorkoutPlan(WorkoutPlan plan) {
    try {
      FirebaseFirestore.instance.collection('workout_plans')
                                .doc(plan.firestoreId)
                                .update(plan.toFirestoreMap());
    } catch (e) {
      print('Error updating WorkoutPlan in Firestore: $e');
    }
  }

  Future<void> deleteWorkoutPlan(WorkoutPlan plan) async {
    final Database db = await DatabaseProvider.instance.database;
    await db.delete(
      'workout_plans',
      where: 'planId = ?',
      whereArgs: [plan.id]
    );
    _deleteCloudWorkoutPlan(plan);
  }

  void _deleteCloudWorkoutPlan(WorkoutPlan plan) {
    FirebaseFirestore.instance
      .collection('workout_plans')
      .doc(plan.firestoreId)
      .delete()
      .then((_) {
        print('WorkoutPlan deleted from Firestore: $plan');
      }).catchError((e) {
        print('Error deleting WorkoutPlan from Firestore: $e');
      });
  }


  // ---------------------------------------------------------------
  // FitnessLogs control

  Future<FitnessLogs> getFitnessLogs(Account account) async {
    final Database db = await DatabaseProvider.instance.database;
    List<Map<String, dynamic>> sessionMaps = await db.query(
      'session_logs',
      where: 'accountEmail = ?',
      whereArgs: [account.email],
    );

    // Query all sets for returned sessions
    if(sessionMaps.isNotEmpty) {
      List setFutures = sessionMaps.map((sessionMap) => db.query(
        'set_logs',
        where: 'session_log_id = ?',
        whereArgs: [sessionMap['id']]
      )).toList();

      List<SessionLog> sessions = sessionMaps.map((sessionMap) {
        return SessionLog.fromMap(sessionMap);
      }).toList();
      for(int i=0; i<sessionMaps.length; i++) {
        sessions[i].sets = (await setFutures[i]).map((setMap) {
          if(setMap['reps'] == null) return CardioSetLog.fromMap(setMap);
          else                       return ResistanceSetLog.fromMap(setMap);
        }).toList().cast<SetLog>();
      }

      return FitnessLogs(entries: sessions);
    }

    // Query firestore if local db is empty
    else return _getFitnessLogsCloud(account);
  }

  Future<FitnessLogs> _getFitnessLogsCloud(Account account) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance
        .collection('session_logs')
        .where('accountEmail', isEqualTo: account.email)
        .get();

    List<Map<String, dynamic>> sessionMaps = querySnapshot.docs.map(
      (doc) => doc.data()
    ).toList();

    List<SessionLog> sessions = sessionMaps.map((sessionMap) {
      return SessionLog.fromMap(sessionMap);
    }).toList();

    // Query all sets for returned sessions
    if(sessionMaps.isNotEmpty) {
      for(int i=0; i<sessionMaps.length; i++) {
        querySnapshot = await FirebaseFirestore.instance
          .collection('set_logs')
          .where('session_log_id', isEqualTo: sessionMaps[i]['id'])
          .get();

        sessions[i].sets = querySnapshot.docs.map((doc) {
          Map<String, dynamic> setMap = doc.data();
          if(setMap['reps'] == null) return CardioSetLog.fromMap(setMap);
          else                       return ResistanceSetLog.fromMap(setMap);
        }).toList().cast<SetLog>();
      }
    }

    return FitnessLogs(entries: sessions);
  }


  // ---------------------------------------------------------------
  // SessionLog control

  Future<void> addSessionLog(SessionLog log) async {
    final Database db = await DatabaseProvider.instance.database;
    log.id = await db.insert(
      'session_logs',
      log.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
    _addSessionLogCloud(log);
    log.sets.forEach((setLog) => addSetLog(setLog, log.id!));
  }

  void _addSessionLogCloud(SessionLog log) {
    final ref = FirebaseFirestore.instance.collection('session_logs').doc();
    try {
      ref.set(log.toFirestoreMap());
      log.firestoreId = ref.id;
      updateSessionLog(log, false);
    } catch (e) {
      print('Error adding SessionLog to Firestore: $e');
    }
  }

  Future updateSessionLog(SessionLog log, [bool updateCloud=true]) async {
    final Database db = await DatabaseProvider.instance.database;
    db.update(
      'session_logs',
      log.toMap(),
      where: 'id = ?',
      whereArgs: [log.id]
    );
    if(updateCloud) _updateSessionLogCloud(log);
  }

  void _updateSessionLogCloud(SessionLog log) {
    try {
      FirebaseFirestore.instance.collection('session_logs')
                                .doc(log.firestoreId)
                                .update(log.toFirestoreMap());
    } catch (e) {
      print('Error updating SessionLog in Firestore: $e');
    }
  }

  Future<void> deleteSessionLog(SessionLog log) async {
    final Database db = await DatabaseProvider.instance.database;
    log.sets.forEach((setLog) => deleteSetLog(setLog));
    await db.delete(
      'session_logs',
      where: 'id = ?',
      whereArgs: [log.id]
    );
    _deleteSessionLogCloud(log);
  }

  void _deleteSessionLogCloud(SessionLog log) {
    FirebaseFirestore.instance
      .collection('session_logs')
      .doc(log.firestoreId)
      .delete()
      .then((_) {
        print('SessionLog deleted from Firestore: $log');
      }).catchError((e) {
        print('Error deleting SessionLog from Firestore: $e');
      });
  }


  // ---------------------------------------------------------------
  // SetLog control

  Future<void> addSetLog(SetLog log, int session_log_id) async {
    final Database db = await DatabaseProvider.instance.database;
    Map<String, dynamic> map = log.toMap();
    map['session_log_id'] = session_log_id;
    log.id = await db.insert(
      'set_logs',
      map,
      conflictAlgorithm: ConflictAlgorithm.replace
    );
    _addSetLogCloud(log, session_log_id);
  }

  void _addSetLogCloud(SetLog log, int session_log_id) {
    final ref = FirebaseFirestore.instance.collection('set_logs').doc();
    Map<String, dynamic> map = log.toFirestoreMap();
    map['session_log_id'] = session_log_id;
    try {
      ref.set(map);
      log.firestoreId = ref.id;
      updateSetLog(log, false);
    } catch (e) {
      print('Error adding SetLog to Firestore: $e');
    }
  }

  Future<void> updateSetLog(SetLog log, [bool updateCloud=true]) async {
    final Database db = await DatabaseProvider.instance.database;
    db.update(
      'set_logs',
      log.toMap(),
      where: 'id = ?',
      whereArgs: [log.id]
    );
    if(updateCloud) _updateSetLogCloud(log);
  }

  void _updateSetLogCloud(SetLog log) {
    try {
      FirebaseFirestore.instance.collection('set_logs')
                                .doc(log.firestoreId)
                                .update(log.toFirestoreMap());
    } catch (e) {
      print('Error updating SetLog in Firestore: $e');
    }
  }

  Future<void> deleteSetLog(SetLog log) async {
    final Database db = await DatabaseProvider.instance.database;
    await db.delete(
      'set_logs',
      where: 'id = ?',
      whereArgs: [log.id]
    );
    _deleteSetLogCloud(log);
  }

  void _deleteSetLogCloud(SetLog log) {
    FirebaseFirestore.instance
      .collection('set_logs')
      .doc(log.firestoreId)
      .delete()
      .then((_) {
        print('SetLog deleted from Firestore: $log');
      }).catchError((e) {
        print('Error deleting SetLog from Firestore: $e');
      });
  }
}
