import 'package:flutter/material.dart';
import 'package:life_balance_plus/data/enums/equipment.dart';
import 'package:life_balance_plus/data/enums/muscle_group.dart';
import 'package:life_balance_plus/data/model/exercise.dart';
import 'package:life_balance_plus/data/model/workout_plan.dart';
import 'package:life_balance_plus/view/widgets/add_exercise_dialog.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:life_balance_plus/control/workouts_control.dart';

class AddProgramDialog extends StatefulWidget {
  const AddProgramDialog({super.key});

  @override
  State<AddProgramDialog> createState() => _AddProgramDialogState();
}

class _AddProgramDialogState extends State<AddProgramDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _modalFormKey = GlobalKey<FormFieldState>();

  final programNameFieldController = TextEditingController();
  final typeDropDownKey = GlobalKey<FormFieldState>();

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    programNameFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Exercise> exercises = [];
    List<List<ExercisePlan>> sessions = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Program'),
        toolbarHeight: 104,
      ),
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Program Name',
                    ),
                    controller: programNameFieldController,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    maxLength: 50,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Program name is required';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField(
                    key: typeDropDownKey,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Training Type',
                    ),
                    hint: const Text('Select Training Type'),
                    value: null,
                    onChanged: (dynamic newValue) {
                      setState(() {
                        typeDropDownKey.currentState?.didChange(newValue);
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Training type is required';
                      }
                      return null;
                    },
                    isExpanded: true,
                    items:
                        WorkoutPlanType.values.map((WorkoutPlanType equipment) {
                      return DropdownMenuItem(
                        value: equipment,
                        child: Text(equipment.name),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  const Divider(thickness: 2),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sessions',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        TextButton.icon(
                          label: const Text('Add Session'),
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            openSessionCreatorModal(
                                context, exercises, sessions);
                          },
                        ),
                      ],
                    ),
                  ),
                  // TODO: Sessions should be visibile in this scrollview
                  Container(
                    height: MediaQuery.of(context).size.height * 0.42,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListView.builder(
                      itemCount: sessions.length,
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                          title: Text('Session ${index + 1}'),
                          children: sessions[index].map((exercisePlan) {
                            return ListTile(
                              title: Text(exercisePlan.exercise.name),
                              subtitle: Text(
                                  '${exercisePlan.sets} x ${exercisePlan.repTarget}'),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _save,
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> openSessionCreatorModal(BuildContext context,
      List<Exercise> exercises, List<List<ExercisePlan>> sessions) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _modalFormKey,
            child: Column(
              children: [
                Text(
                  'New Session Creator',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  child: const Text('Add Exercise'),
                  onPressed: () async {
                    final Exercise newExercise = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddExercisePage()),
                    );
                    setState(() {
                      exercises.add(newExercise);

                      sessions.add([
                        ExercisePlan(
                          exercise: newExercise,
                          sets: 3,
                          repTarget: 10,
                        )
                      ]);
                    });
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: exercises.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Text(exercises[index].name),
                          subtitle: Text(exercises[index]
                              .muscleGroups
                              .map((e) => e.name)
                              .join(' | '))
                          // TODO: Trailing with set and rep info
                          );
                    },
                  ),
                ),
                const Divider(thickness: 2),
                ElevatedButton(
                  child: const Text('Save'),
                  onPressed: () {
                    // TODO: THE ISSUE IS HERE, BREAKS ON SAVE
                    if (_modalFormKey.currentState!.validate()) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _save() async {}
}
