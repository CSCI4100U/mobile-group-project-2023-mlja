import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_balance_plus/data/model/session.dart';
import 'package:life_balance_plus/data/model/account.dart';
import 'package:life_balance_plus/data/model/fitness_logs.dart';

class WorkoutDashboardHistoryCard extends StatelessWidget {
  final SessionLog log;

  const WorkoutDashboardHistoryCard({
    super.key,
    required this.log,
  });

  @override
  Widget build(BuildContext context) {
    UnitsSystem units = Session.instance.account!.unitsSystem;

    // DataTable size properties
    double horizontalPad  = 18;
    double tableWidth     = MediaQuery.of(context).size.width - 2*horizontalPad;
    double columnSpacing  = 32;
    double maxNameWidth   = 0.3 * (tableWidth - 2*columnSpacing);
    double numberColWidth = 0.5 * (tableWidth - maxNameWidth);

    // Column labels
    String col1Label = '';
    String col2Label = '';
    bool hasResistanceSets = false;
    bool hasCardioSets = false;

    if(log.sets.any((set) => set is ResistanceSetLog)) {
      hasResistanceSets = true;
      col1Label = 'Reps';
      col2Label = 'Weight';
    }
    if(log.sets.any((set) => set is CardioSetLog)) {
      hasCardioSets = true;
      if(hasResistanceSets) {
        col1Label += '/\nMinutes';
        col2Label += '/\nAvg Speed';
      } else {
        col1Label = 'Minutes';
        col2Label = 'Avg Speed (${units == UnitsSystem.metric? 'kmph':'mph'})';
      }
    }
    else {
      col2Label += ' (${units == UnitsSystem.metric? 'kgs':'lbs'})';
    }

    // Values for determining row appearance
    String previousExerciseName = '';
    Color rowColour = Colors.grey.shade200;

    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 4,
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
            padding: EdgeInsets.symmetric(horizontal: horizontalPad),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat.yMMMd().format(log.date),
                  style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)
                ),
                TextButton.icon(
                  label: const Text('Notes'),
                  icon: const Icon(Icons.notes_outlined),
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Notes'),
                      content: (log.notes.isEmpty)?
                        Text('This workout has no notes.') : SizedBox(
                          height: 600,
                          width: 600,
                          child: ListView.builder(
                            itemCount: log.notes.length,
                            itemBuilder: (context, i) =>  Text(log.notes[i]),
                          )
                        ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: DataTable(
              dataRowMaxHeight: double.infinity,
              columnSpacing: columnSpacing,
              columns: [
                DataColumn(label: Text('Exercise')),
                DataColumn(
                  label: Text(col1Label),
                  numeric: true,
                ),
                DataColumn(
                  label: Text(col2Label),
                  numeric: true,
                ),
              ],
              rows: log.sets.map((set) {
                String name = '';
                String repsOrDuration;
                String weightOrAvgSpeed;

                // Determine row color and whether exercise name is displayed
                if(set.exercise.name != previousExerciseName) {
                  name = set.exercise.name;
                  rowColour = (rowColour == Colors.white)?
                    Colors.grey.shade200 : Colors.white;
                  previousExerciseName = name;
                }

                // Remove decimal from rep number string
                if(set is ResistanceSetLog) {
                  repsOrDuration = set.repsOrDuration.toStringAsFixed(0);
                } else {
                  repsOrDuration = set.repsOrDuration.toStringAsFixed(1);
                }

                // Attach units to weight/speed if both are used
                if(set.weightOrAvgSpeed == null) {
                  weightOrAvgSpeed = 'N/A';
                } else {
                  weightOrAvgSpeed = '${set.weightOrAvgSpeed}';
                  if(hasResistanceSets && hasCardioSets) {
                    if(set is CardioSetLog) {
                      weightOrAvgSpeed += (units == UnitsSystem.metric)?
                        ' (kmph)' : ' (mph)';
                    } else {
                      weightOrAvgSpeed += (units == UnitsSystem.metric)?
                        ' (kgs)' : ' (lbs)';
                    }
                  }
                }

                return DataRow(
                  color: MaterialStateProperty.all(rowColour),
                  cells: [
                    DataCell(
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: maxNameWidth),
                        child: Text(name),
                      )
                    ),
                    DataCell(
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: numberColWidth),
                        child: Text(repsOrDuration),
                      )
                    ),
                    DataCell(
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: numberColWidth),
                        child: Text(weightOrAvgSpeed),
                      )
                    ),
                  ]
                );
              }).toList(),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
