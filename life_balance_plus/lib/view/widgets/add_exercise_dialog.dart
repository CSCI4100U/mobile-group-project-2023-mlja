import 'package:flutter/material.dart';
import 'package:life_balance_plus/data/enums/equipment.dart';
import 'package:life_balance_plus/data/enums/muscle_group.dart';
import 'package:life_balance_plus/data/model/exercise.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:life_balance_plus/control/workouts_control.dart';
import 'package:life_balance_plus/data/model/workout_plan.dart';

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

  bool muscleGroupsInvalid = true;
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
                    maxLines: 2,
                  ),
                  const Divider(height: 40, thickness: 2),
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
                                  if (value == null || value.isEmpty) {
                                    return 'Sets is required';
                                  }
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
                                  if (value == null || value.isEmpty) {
                                    return 'Reps is required';
                                  }
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
                  const Divider(height: 40, thickness: 2),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        'Muscle Groups:',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  FormField(
                    builder: (field) {
                      return MultiSelectDropDown(
                        controller: muscleGroupController,
                        selectionType: SelectionType.multi,
                        dropdownHeight:
                            MediaQuery.of(context).size.height * 0.5,
                        onOptionSelected: (selectedOptions) {
                          setState(() => muscleGroupsInvalid = true);
                        },
                        backgroundColor: Colors.transparent,
                        inputDecoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade600),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        hint: 'Select Muscle Groups',
                        hintStyle: Theme.of(context).textTheme.titleMedium,
                        padding: const EdgeInsets.only(left: 4, right: 10),
                        options: MuscleGroup.values
                            .map((muscleGroup) => ValueItem<MuscleGroup>(
                                  value: muscleGroup,
                                  label: muscleGroup.string,
                                ))
                            .toList(),
                      );
                    },
                    validator: (_) {
                      if (muscleGroupController.selectedOptions.isEmpty) {
                        setState(() {
                          muscleGroupsInvalid = false;
                        });
                        return '';
                      }
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, top: 8),
                      child: Text(
                        'Muscle Groups are required',
                        style: TextStyle(
                            color: muscleGroupsInvalid
                                ? Colors.transparent
                                : Colors.red,
                            fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  DropdownButtonFormField(
                    key: equipmentDropDownKey,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Required Equipment',
                    ),
                    hint: const Text('Select Equipment'),
                    value: null,
                    onChanged: (dynamic newValue) {
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Equipment is required';
                      }
                      return null;
                    },
                    isExpanded: true,
                    items: Equipment.values.map((Equipment equipment) {
                      return DropdownMenuItem(
                        value: equipment,
                        child: Text(equipment.string),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 30),
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
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Exercise Added!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pop(
        context,
        ExercisePlan(
          sets: int.parse(setsFieldController.value.text),
          repTarget: int.parse(repsFieldController.value.text),
          exercise: Exercise(
            name: nameFieldController.text,
            description: descriptionFieldController.text,
            muscleGroups: muscleGroupController.selectedOptions.map((element) {
              return element.value!;
            }).toList(),
            requiredEquipment: [equipmentDropDownKey.currentState?.value],
          ),
        ),
      );
    }
  }
}
