import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:life_balance_plus/data/model/workout_plan.dart';
import 'package:life_balance_plus/data/model/session.dart';

class ProgramTabPage extends StatefulWidget {
  const ProgramTabPage({super.key});

  @override
  State<ProgramTabPage> createState() => _ProgramTabPageState();
}

class _ProgramTabPageState extends State<ProgramTabPage> {
  late List<WorkoutPlan> programs;

  @override
  void initState() {
    super.initState();
    programs = Session.instance.workoutPlans!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(    
      body: ListView.builder(
        itemCount: programs.length,
        itemBuilder: (context, i) => WorkoutDashboardProgramCard(programs[i])
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Add Program'),
        onPressed: () {},
      ),
    );
  }

  WorkoutDashboardProgramCard(WorkoutPlan plan) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 30,
            color: Colors.black,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(plan.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
            child: Column(
              children: [
                ...plan.sessions.mapIndexed((index, session) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (session.isEmpty)? 'Rest Day' : 'Day ${index+1}',
                        style: Theme.of(context).textTheme.titleLarge
                      ),
                      const Divider(height: 6),
                      ...session.map((exercisePlan) {
                        return Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                exercisePlan.exercise.name,
                                style: Theme.of(context).textTheme.bodyLarge?.
                                  copyWith(fontSize: 17),
                              ),
                              Text(
                                '${exercisePlan.sets} set${exercisePlan.sets > 1? 's':''}'
                                ' • ${exercisePlan.repTarget == null?
                                  '${exercisePlan.targetDuration} minutes' :
                                  '${exercisePlan.repTarget} reps '}'
                              )
                            ]
                          )
                        );
                      }).toList(),
                      const Divider(),
                    ]
                  );
                }).toList(),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            trailing: TextButton.icon(
              icon: Icon(Icons.arrow_forward_ios),
              label: Text('Start Workout'),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
