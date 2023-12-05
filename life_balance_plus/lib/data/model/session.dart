import 'package:life_balance_plus/data/model/workout_plan.dart';

import 'account.dart';
import 'fitness_logs.dart';

/// Represents the current app session, storing the signed in account, the
/// workout plans, and fitness logs.
class Session {

  // Singleton pattern
  Session._singletonConstructor();
  static final Session instance = Session._singletonConstructor();

  Account? account;
  List<WorkoutPlan>? workoutPlans;
  FitnessLogs? fitnessLogs;
}
