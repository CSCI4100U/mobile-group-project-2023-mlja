import 'dart:convert';


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
      'id': id,
      'firestoreId': firestoreId,
      ...toFirestoreMap(),
    };
  }

  Map<String, dynamic> toFirestoreMap() {
    return {
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
      sessions: jsonDecode(
        map['sessions']
      ).cast<List<Map<String, dynamic>>>()
       .map((session) => session.map((exercise) {
         return ExercisePlan.fromMap(exercise);
       }).toList()
      ).toList()
    );
  }

  void addSession(List<ExercisePlan> session) {
    sessions.add(session);
  }
}


/// Defines the plan for a single exercise in a WorkoutPlan.
class ExercisePlan {
  String name;
  int sets;
  int? repTarget;       // Number of reps to aim for in each set for resistance training
  int? targetDuration;  // Target duration for cardio exercise

  ExercisePlan({required this.name, required this.sets, this.repTarget, this.targetDuration});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'sets': sets,
      'repTarget': repTarget,
      'targetDuration': targetDuration,
    };
  }

  factory ExercisePlan.fromMap(Map<String, dynamic> map) {
    return ExercisePlan(
      name: map['name'],
      sets: map['sets'],
      repTarget: map['repTarget'],
      targetDuration: map['targetDuration'],
    );
  }
}
