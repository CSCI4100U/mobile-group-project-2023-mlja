import 'package:flutter/material.dart';
import 'package:life_balance_plus/data/enums/equipment.dart';
import 'package:life_balance_plus/data/enums/muscle_group.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class AddExercisePage extends StatefulWidget {
  const AddExercisePage({super.key});

  @override
  State<AddExercisePage> createState() => _AddExercisePageState();
}

class _AddExercisePageState extends State<AddExercisePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final nameFieldController = TextEditingController();
  final descriptionFieldController = TextEditingController();
  final setsFieldController = TextEditingController();
  final repsFieldController = TextEditingController();

  final muscleGroupsDropDownKey = GlobalKey<FormFieldState>();
  final MultiSelectController<MuscleGroup> muscleGroupController =
      MultiSelectController<MuscleGroup>();

  final equipmentDropDownKey = GlobalKey<FormFieldState>();

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    nameFieldController.dispose();
    descriptionFieldController.dispose();
    setsFieldController.dispose();
    repsFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Exercise'),
        toolbarHeight: 104,
      ),
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                    controller: nameFieldController,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    maxLength: 50,
                    onSaved: (newValue) {
                      nameFieldController.clear();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                      labelText: 'Description (optional)',
                      hintText:
                          '(e.g. notes, instructions, form tips, variations, etc.)',
                    ),
                    controller: descriptionFieldController,
                    onSaved: (newValue) {
                      descriptionFieldController.clear();
                    },
                    maxLines: 2,
                  ),
                  const Divider(height: 50, thickness: 2),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Sets',
                                ),
                                controller: setsFieldController,
                                keyboardType: TextInputType.number,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onSaved: (newValue) {
                                  setsFieldController.clear();
                                },
                                validator: (value) {
                                  // if (value == null || value.isEmpty) {
                                  //   return 'Sets is required';
                                  // }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 33,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      int currentSets = int.tryParse(
                                              setsFieldController.text) ??
                                          0;
                                      setsFieldController.text =
                                          (currentSets + 1).toString();
                                    },
                                    child: const Icon(Icons.add),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  height: 33,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      int currentSets = int.tryParse(
                                              setsFieldController.text) ??
                                          0;
                                      if (currentSets > 0) {
                                        setsFieldController.text =
                                            (currentSets - 1).toString();
                                      }
                                    },
                                    child: const Icon(Icons.remove),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Reps',
                                ),
                                controller: repsFieldController,
                                keyboardType: TextInputType.number,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onSaved: (newValue) {
                                  repsFieldController.clear();
                                },
                                validator: (value) {
                                  // if (value == null || value.isEmpty) {
                                  //   return 'Reps is required';
                                  // }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 33,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      int currentReps = int.tryParse(
                                              repsFieldController.text) ??
                                          0;
                                      repsFieldController.text =
                                          (currentReps + 1).toString();
                                    },
                                    child: const Icon(Icons.add),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  height: 33,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      int currentReps = int.tryParse(
                                              repsFieldController.text) ??
                                          0;
                                      if (currentReps > 0) {
                                        repsFieldController.text =
                                            (currentReps - 1).toString();
                                      }
                                    },
                                    child: const Icon(Icons.remove),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 50, thickness: 2),
                  DropdownButtonFormField(
                    key: muscleGroupsDropDownKey,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Muscle Groups',
                    ),
                    hint: const Text('Select Muscle Groups'),
                    value: null,
                    onChanged: (dynamic newValue) {
                      setState(() {
                        muscleGroupsDropDownKey.currentState
                            ?.didChange(newValue);
                      });
                    },
                    isExpanded: true,
                    items: MuscleGroup.values
                        .map((group) => DropdownMenuItem(
                              value: group,
                              child: Text(group.toString()),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 30),
                  DropdownButtonFormField(
                    key: equipmentDropDownKey,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Required Equipment',
                    ),
                    hint: const Text('Select Equipment'),
                    value: null,
                    onChanged: (dynamic newValue) {
                      setState(() {
                        equipmentDropDownKey.currentState?.didChange(newValue);
                      });
                    },
                    isExpanded: true,
                    items: Equipment.values.map((Equipment equipment) {
                      return DropdownMenuItem(
                        value: equipment,
                        child: Text(equipment.toString()),
                      );
                    }).toList(),
                  ),
                  // MultiSelectDropDown(
                  //   controller: muscleGroupController,
                  //   selectionType: SelectionType.multi,
                  //   onOptionSelected: (selectedOptions) {
                  //     print(selectedOptions);
                  //     print(muscleGroupController.options);
                  //   },
                  //   options: MuscleGroup.values
                  //       .map((muscleGroup) => ValueItem<MuscleGroup>(
                  //             value: muscleGroup,
                  //             label: muscleGroup.toString(),
                  //           ))
                  //       .toList(),
                  // ),
                  const SizedBox(height: 40),
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

  Future<void> _save() async {
    // TODO: Backend Integration - insert exercise to db
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }
}
