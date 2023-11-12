import 'package:flutter/material.dart';
import 'package:life_balance_plus/view/pages/workout/dashboard_gym.dart';
import 'package:life_balance_plus/view/widgets/custom_tabbar.dart';
import '../../../data/model/workout_plan.dart';
import '../../../control/exercises_control.dart';

class WorkoutPage extends StatefulWidget {
  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  List<ExercisePlan> exs = [];

  Future<void> _loadExercises() async {
    final exs_ = await ExerciseControl().getAllExercises();
    setState(() {
      exs = exs_;
    });
  }

  @override
  void initState() {
    super.initState();
    // Uncomment this the first time you run to add some exercises to the local db
    ExerciseControl().addDummyData();
    _loadExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomTabbar(
            pages: [
              NestedTabBar(),
              Center(
                child: ListView.builder(
                  itemCount: exs.length,
                  itemBuilder: (context, index) {
                    final ex = exs[index];
                    return ListTile(
                      title: Text(ex.name),
                      subtitle: Text('Sets: ${ex.sets}'),
                    );
                  },
                ),
              ),
              const Center(child: Text('Programs')),
            ],
            tabNames: const ['Dashboard', 'Exercises', 'Programs'],
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
                Tab(text: 'History'),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                DashboardGym(),
                Center(child: Text('Run')),
                Center(child: Text('History')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
