import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_balance_plus/data/model/workout_plan.dart';

class ProgramTabPage extends StatefulWidget {
  const ProgramTabPage({super.key});

  @override
  State<ProgramTabPage> createState() => _ProgramTabPageState();
}

class _ProgramTabPageState extends State<ProgramTabPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // WorkoutDashboardProgramCard(
        //   WorkoutPlan(
        //       title: 'TEST',
        //       startDate: DateTime.now(),
        //       type: WorkoutPlanType.custom),
        // ),
        // WorkoutDashboardProgramCard(
        //   WorkoutPlan(
        //       title: 'TEST2',
        //       startDate: DateTime.now(),
        //       type: WorkoutPlanType.endurance),
        // ),
        // WorkoutDashboardProgramCard(
        //   WorkoutPlan(
        //       title: 'TEST3',
        //       startDate: DateTime.now(),
        //       type: WorkoutPlanType.sportsSpecific),
        // ),
      ],
    );
  }

  WorkoutDashboardProgramCard(WorkoutPlan plan) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        // side: const BorderSide(color: Colors.black, width: 2),
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
                // Text(
                //   plan.endDate != null
                //       ? '${DateFormat.yMMMd().format(plan.startDate)} - ${DateFormat.yMMMd().format(plan.endDate!)}'
                //       : DateFormat.yMMMd().format(plan.startDate),
                //   style: Theme.of(context)
                //       .textTheme
                //       .bodyLarge
                //       ?.copyWith(color: Colors.black54),
                // ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lat Pulldowns',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 17,
                          ),
                    ),
                    Text(
                      '2 Sets',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Back',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.grey),
                    ),
                    Text(
                      '50 Kg',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
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