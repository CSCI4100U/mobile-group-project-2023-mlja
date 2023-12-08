import 'package:flutter/material.dart';
import 'package:life_balance_plus/data/model/exercise.dart';
import 'package:life_balance_plus/data/model/workout_plan.dart';

class WorkoutSessionPage extends StatefulWidget {
  final WorkoutPlan? workoutPlan;
  const WorkoutSessionPage({
    super.key,
    this.workoutPlan,
  });

  @override
  State<WorkoutSessionPage> createState() => _WorkoutSessionPageState();
}

class _WorkoutSessionPageState extends State<WorkoutSessionPage> {
  final _formKey = GlobalKey<FormState>();
  List<Set> data = [Set(set: 1, weight: 0, reps: 0)];
  int sets = 1;
  List<Exercise> exercises = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    data.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upper Split'),
        actions: [
          IconButton(
            icon: Icon(Icons.timer),
            onPressed: () => _showTimerDialog(context),
          ),
        ],
      ),
      body: data.length < 1
          ? Center(child: Text('No items'))
          : Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Set ${index + 1}'),
                        SizedBox(
                          width: 50,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                data[index].weight = double.parse(value);
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  data[index].reps = int.parse(value);
                                });
                              }),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteRow(index);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addRow,
        child: Icon(Icons.add),
      ),
    );
  }

  void _deleteRow(int index) {
    setState(() {
      data.removeAt(index);
      sets--;
    });
  }

  void _addRow() {
    setState(() {
      sets++;
      data.add(Set(set: sets, weight: 0, reps: 0));
    });
  }

  Future<void> _showTimerDialog(BuildContext context) async {
    int selectedTime = 60; // Default time in minutes

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Timer'),
          content: Column(
            children: [
              Text('Select time in minutes:'),
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Minutes'),
                onChanged: (value) {
                  selectedTime = int.tryParse(value) ?? selectedTime;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add timer functionality here using selectedTime
                Navigator.of(context).pop();
              },
              child: Text('Start'),
            ),
          ],
        );
      },
    );
  }
}

class Set {
  int set;
  double weight;
  int reps;

  Set({
    required this.set,
    required this.weight,
    required this.reps,
  });
}
