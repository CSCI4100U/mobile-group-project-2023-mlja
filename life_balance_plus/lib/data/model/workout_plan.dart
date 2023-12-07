import 'dart:convert';
import 'package:life_balance_plus/data/enums/equipment.dart';
import 'package:life_balance_plus/data/enums/muscle_group.dart';
import 'package:life_balance_plus/data/model/exercise.dart';


enum WorkoutPlanType {
  hypertrophy,    // Focused on muscle growth
  strength,       // Focused on building strength
  endurance,      // Focused on improving endurance and stamina
  flexibility,    // Focused on increasing flexibility
  weightLoss,     // Focused on weight loss and cardio
  powerlifting,   // Focused on powerlifting exercises (e.g., squat, bench press, deadlift)
  bodyweight,     // Focused on exercises that use body weight (e.g., calisthenics)
  crossfit,       // Focused on CrossFit-style workouts
  sportsSpecific, // Focused on sport-specific training
  rehabilitation, // Focused on recovery and rehabilitation exercises
  generalFitness, // General fitness and wellness
  custom,         // Custom or user-defined plan
}


/// A planned workout program. Allows the user to define a schedule with any
/// number of days, such as 7 for a weekly schedule, and plan the exercises that
/// will be performed on each day along with the number of sets for each, and
/// the target number of reps for each set if it is a resistance training
/// exercise, or the target duration for a cardio exercise.
class WorkoutPlan {
  int? id;
  String? firestoreId;
  String accountEmail;  // Email address of associated account
  String title;
  WorkoutPlanType type;

  /// List of sessions in a workout plan, where the sessions are lists of
  /// exercises. Empty exercise lists denote rest days.
  List<List<ExercisePlan>> sessions;

  WorkoutPlan({
    this.id,
    this.firestoreId,
    required this.accountEmail,
    required this.title,
    required this.type,
    List<List<ExercisePlan>>? sessions,
  }) : this.sessions = sessions ?? [];

  Map<String, dynamic> toMap() {
    return {
      'firestoreId': firestoreId,
      ...toFirestoreMap(),
    };
  }

  Map<String, dynamic> toFirestoreMap() {
    return {
      'id': id,
      'accountEmail': accountEmail,
      'title': title,
      'type': type.name,
      'sessions': jsonEncode(sessions.map((session) {
        return session.map((exercise) => exercise.toMap()).toList();
      }).toList())
    };
  }

  factory WorkoutPlan.fromMap(Map<String, dynamic> map) {
    return WorkoutPlan(
      id: map.containsKey('id')? map['id'] : null,
      firestoreId: map.containsKey('firestoreId')? map['firestoreId'] : null,
      accountEmail: map['accountEmail'],
      title: map['title'] as String,
      type: WorkoutPlanType.values.byName(map['type']),
      sessions: jsonDecode(map['sessions']).map((session) =>
        List<Map<String, dynamic>>.from(session).map((exercise) {
          return ExercisePlan.fromMap(exercise);
        }).toList()
      ).toList().cast<List<ExercisePlan>>()
    );
  }

  void addSession(List<ExercisePlan> session) {
    sessions.add(session);
  }
}


/// Defines the plan for a single exercise in a WorkoutPlan.
class ExercisePlan {
  Exercise exercise;
  int sets;
  int? repTarget;       // Number of reps to aim for in each set for resistance training
  int? targetDuration;  // Target duration for cardio exercise

  ExercisePlan({
    required this.exercise,
    required this.sets,
    this.repTarget,
    this.targetDuration});

  Map<String, dynamic> toMap() {
    return {
      'name': exercise.name,
      'description': exercise.description,
      'muscleGroups': exercise.muscleGroups.fold(
        '', (str, group) => '$str${group.name},'
      ),
      'requiredEquipment': exercise.requiredEquipment.fold(
        '', (str, equipment) => '$str${equipment.name},'
      ),
      'sets': sets,
      'repTarget': repTarget,
      'targetDuration': targetDuration,
    };
  }

  factory ExercisePlan.fromMap(Map<String, dynamic> map) {
    return ExercisePlan(
      exercise: Exercise(
        name: map['name'],
        description: map['description'],
        muscleGroups: (map['muscleGroups'] == '')? []
          : (map['muscleGroups']
              .split(',')
              .where((str) => str != '')
              .map((group) => MuscleGroup.values.byName(group))
              .toList().cast<MuscleGroup>()
            ),
        requiredEquipment: (map['requiredEquipment'] == '')? []
          : (map['requiredEquipment']
              .split(',')
              .where((str) => str != '')
              .map((equipment) => Equipment.values.byName(equipment))
              .toList().cast<Equipment>()
            ),
      ),
      sets: map['sets'],
      repTarget: map['repTarget'],
      targetDuration: map['targetDuration'],
    );
  }
}
