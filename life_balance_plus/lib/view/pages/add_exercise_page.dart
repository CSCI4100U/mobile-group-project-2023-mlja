import 'package:flutter/material.dart';

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
  final equipmentDropDownKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Exercise'),
      ),
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                    controller: nameFieldController,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    items: const [
                      // TODO: Replace with enum iterator
                      DropdownMenuItem(
                        value: 'Chest',
                        child: Text('Chest'),
                      ),
                      DropdownMenuItem(
                        value: 'Back',
                        child: Text('Back'),
                      ),
                      DropdownMenuItem(
                        value: 'Shoulders',
                        child: Text('Shoulders'),
                      ),
                      DropdownMenuItem(
                        value: 'Biceps',
                        child: Text('Biceps'),
                      ),
                      DropdownMenuItem(
                        value: 'Triceps',
                        child: Text('Triceps'),
                      ),
                      DropdownMenuItem(
                        value: 'Quadriceps',
                        child: Text('Quadriceps'),
                      ),
                      DropdownMenuItem(
                        value: 'Hamstrings',
                        child: Text('Hamstrings'),
                      ),
                      DropdownMenuItem(
                        value: 'Calves',
                        child: Text('Calves'),
                      ),
                      DropdownMenuItem(
                        value: 'Abs',
                        child: Text('Abs'),
                      ),
                    ],
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
                    items: const [
                      // TODO: Replace with enum iterator
                      DropdownMenuItem(
                        value: 'Bench',
                        child: Text('Bench'),
                      ),
                      DropdownMenuItem(
                        value: 'Machine',
                        child: Text('Machine'),
                      ),
                      DropdownMenuItem(
                        value: 'Dumbells',
                        child: Text('Dumbells'),
                      ),
                      DropdownMenuItem(
                        value: '...',
                        child: Text('...'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
