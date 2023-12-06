import 'exercise.dart';
import 'dart:convert';

enum WorkoutPlanType {
  hypertrophy, // Focused on muscle growth
  strength,    // Focused on building strength
  endurance,   // Focused on improving endurance and stamina
  flexibility, // Focused on increasing flexibility
  weightLoss,  // Focused on weight loss and cardio
  powerlifting, // Focused on powerlifting exercises (e.g., squat, bench press, deadlift)
  bodyweight,  // Focused on exercises that use body weight (e.g., calisthenics)
  crossfit,    // Focused on CrossFit-style workouts
  sportsSpecific, // Focused on sport-specific training
  rehabilitation, // Focused on recovery and rehabilitation exercises
  generalFitness, // General fitness and wellness
  custom,        // Custom or user-defined plan
}

class WorkoutPlan {
  int? planId;
  String? firestoreId;
  String title;
  DateTime startDate;
  DateTime? endDate;
  WorkoutPlanType type;
  List<WorkoutSession>? sessions;

  WorkoutPlan({
    this.planId,
    this.firestoreId,
    required this.title,
    required this.startDate,
    this.endDate,
    required this.type,
    this.sessions,
  });

  void addSession(WorkoutSession ws) {
    sessions ??= [];
    sessions!.add(ws);
  }

  Map<String, dynamic> toMap() {
    return {
      'planId': planId,
      'title': title,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'type': type.toString().split('.').last, // Convert enum to string
      'sessions': sessions != null && sessions!.isNotEmpty
          ? jsonEncode(sessions!.map((session) => session.toMap()).toList())
          : null
    }..removeWhere(
      (dynamic key, dynamic value) => value == null);
  }

  factory WorkoutPlan.fromMap(Map<String, dynamic> map) {
    String? dateStr = map['endDate'] as String?;
    DateTime? endDate_;
    if (dateStr != null) {
      endDate_ = DateTime.tryParse(dateStr);
    }

    print(map.toString());
    return WorkoutPlan(
      planId: map['planId'] as int,
      title: map['title'] as String,
      startDate: DateTime.parse(map['startDate']),
      endDate: endDate_,
      type: WorkoutPlanType.values.firstWhere((e) => e.toString().split('.')[1] == map['type']),
      sessions: map['sessions'] != null
          ? (jsonDecode(map['sessions']) as List)
                .map((sessionMap) => WorkoutSession.fromMap(sessionMap))
                .toList()
          : null
    );
  }

}

class WorkoutSession {
  int? sessionId;
  final String? firestoreId;
  int planId;
  final DateTime date;
  List<ExerciseSet> exercises;

  WorkoutSession({
    this.firestoreId,
    this.sessionId,
    required this.planId,
    required this.date,
    required this.exercises,
  });

  void addExercise(ExerciseSet es) {
    exercises.add(es);
  }

  Map<String, dynamic> toMap() {
  return {
      'sessionId': sessionId,
      'date': date.toIso8601String(),
      'exercises': jsonEncode(exercises.map((ex) => ex.toMap()).toList())
    }..removeWhere(
      (dynamic key, dynamic value) => value == null);
  }

  factory WorkoutSession.fromMap(Map<String, dynamic> map) {
    return WorkoutSession(
      sessionId: map['sessionId'],
      firestoreId: map['firestoreId'],
      planId: map['planId'],
      date: DateTime.parse(map['date']),
      exercises: (jsonDecode(map['exercises']) as List)
          .map((exerciseMap) => ExerciseSet.fromMap(exerciseMap))
          .toList(),
    );
  }
}


