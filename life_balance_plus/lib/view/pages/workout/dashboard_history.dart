import 'package:flutter/material.dart';
import 'package:life_balance_plus/view/widgets/workout_dashboard_history_card.dart';
import 'package:life_balance_plus/data/model/session.dart';
import 'package:life_balance_plus/data/model/fitness_logs.dart';


class DashboardHistory extends StatefulWidget {
  const DashboardHistory({super.key});

  @override
  State<DashboardHistory> createState() => _DashboardHistoryState();
}


class _DashboardHistoryState extends State<DashboardHistory> {
  late FitnessLogs logs;

  @override
  void initState() {
    super.initState();
    logs = Session.instance.fitnessLogs!;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            Text('Workout History',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 26),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: logs.entries.length,
              itemBuilder: (context, index) {
                return Column(children: [
                  WorkoutDashboardHistoryCard(
                    log: logs.entries[logs.entries.length-1 - index]
                  ),
                  const Divider(),
                ]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
