import 'package:flutter/material.dart';
import '../../data/model/workout_plan.dart';
import '../../control/exercises_control.dart';

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
    return DefaultTabController(
      // initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kTextTabBarHeight),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white38,
                indicatorColor: Colors.white54,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.white30,
                  ),
                  insets: EdgeInsets.symmetric(vertical: 10),
                ),
                labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                      // fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                unselectedLabelStyle:
                    Theme.of(context).textTheme.titleMedium?.copyWith(
                          letterSpacing: 1.5,
                        ),
                tabs: [
                  Tab(text: 'Dashboard'),
                  Tab(text: 'Exercises'),
                  Tab(text: 'Programs'),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Center(child: Text('Dashboard')),
              Center(
                child: ListView.builder(
                  itemCount: exs.length,
                  itemBuilder: (context, index) {
                    final ex = exs[index];
                    return ListTile(
                      title: Text('${ex.name}'),
                      subtitle: Text('Sets: ${ex.sets}'),
                    );
                  },
                ),
              ),
              Placeholder(),
            ]),
      ),
    );
  }
}
