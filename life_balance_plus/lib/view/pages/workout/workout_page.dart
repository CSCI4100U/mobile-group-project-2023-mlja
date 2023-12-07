import 'package:flutter/material.dart';
import 'package:life_balance_plus/data/model/workout_plan.dart';
import 'package:life_balance_plus/view/pages/workout/dashboard_gym.dart';
import 'package:life_balance_plus/view/pages/workout/dashboard_run.dart';
import 'package:life_balance_plus/view/pages/workout/dashboard_history.dart';
import 'package:life_balance_plus/view/pages/workout/exercise_tab_page.dart';
import 'package:life_balance_plus/control/workouts_control.dart';
import 'package:life_balance_plus/view/pages/workout/program_tab_page.dart';
import 'package:life_balance_plus/view/widgets/custom_tabbar.dart';
import 'package:life_balance_plus/data/model/session.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  List<WorkoutPlan> exs = [];

  Future<void> _loadExercises() async {
    final exs_ = await WorkoutControl().getWorkoutPlans(Session.instance.account!);
    setState(() {
      exs = exs_;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: CustomTabbar(
            pages: [
              NestedTabBar(),
              DashboardHistory(),
              ProgramTabPage(),
            ],
            tabNames: ['Dashboard', 'History', 'Programs'],
          ),
        ),
      ],
    );
  }
}

class NestedTabBar extends StatefulWidget {
  const NestedTabBar({super.key});

  @override
  State<NestedTabBar> createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            height: 50,
            width: MediaQuery.of(context).size.width / 1.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
            ),
            child: TabBar.secondary(
              labelPadding: const EdgeInsets.all(0),
              indicatorPadding:
                  const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
              indicator: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(35),
              ),
              overlayColor: MaterialStateColor.resolveWith(
                (states) => Colors.transparent,
              ),
              labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
              unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
              tabs: const [
                Tab(text: 'Gym'),
                Tab(text: 'Run'),
                Tab(text: 'Exercises'),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                DashboardGym(),
                RunPage(),
                ExerciseTabPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
