import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkoutDashboardHistoryCard extends StatelessWidget {
  final String title;
  final DateTime date;
  final String muscleGroup;
  const WorkoutDashboardHistoryCard({
    super.key,
    required this.title,
    required this.date,
    required this.muscleGroup,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 4,
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
                Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
                Text(
                  DateFormat.yMMMd().format(date),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.black54),
                ),
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
              )),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.fitness_center),
            title: Text('Replay Workout'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
