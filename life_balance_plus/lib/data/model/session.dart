import 'package:life_balance_plus/data/model/workout_plan.dart';

import 'account.dart';
import 'fitness_logs.dart';

class Session {

  // Singleton pattern
  Session._singletonConstructor();
  static final Session instance = Session._singletonConstructor();

  Account? account;
  List<WorkoutPlan>? workoutPlans;
  FitnessLogs? fitnessLogs;
}
