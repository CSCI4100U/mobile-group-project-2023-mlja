import 'package:life_balance_plus/data/model/account.dart';
import 'package:life_balance_plus/control/workouts_control.dart';
import 'package:life_balance_plus/data/model/workout_plan.dart';
import 'package:life_balance_plus/data/model/fitness_logs.dart';

/// Represents the current app session, storing the signed in account, the
/// workout plans, and fitness logs.
class Session {

  // Singleton pattern
  Session._singletonConstructor();
  static final Session instance = Session._singletonConstructor();

  Account? account;
  List<WorkoutPlan>? workoutPlans;
  FitnessLogs? fitnessLogs;

  /// Adds a workout plan to the current session and stores it in the databases.
  void addWorkoutPlan(WorkoutPlan plan) {
    if(workoutPlans == null) workoutPlans = [];
    WorkoutControl().addWorkoutPlan(plan);
    workoutPlans!.add(plan);
  }

  /// Adds a session log to the current session's fitness logs and stores it in
  /// the databases.
  void addSessionLog(SessionLog log) {
    if(fitnessLogs == null) {
      fitnessLogs = FitnessLogs(entries: [log]);
    } else {
      fitnessLogs!.addSessionEntry(log);
    }
    WorkoutControl().addSessionLog(log);
  }
}
