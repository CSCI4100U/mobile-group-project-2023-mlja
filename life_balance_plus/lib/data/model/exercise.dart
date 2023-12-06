import 'dart:convert';

class ExerciseSet {
  int? id;
  String? firestoreId;
  int sessionId;
  String name;
  String? description;
  int? sets;
  int? repetitionsPerSet;
  List<MuscleGroup> muscleGroups;
  List<Equipment> requiredEquipment;

  ExerciseSet({
    this.id,
    this.firestoreId,
    required this.sessionId,
    required this.name,
    this.description,
    this.sets,
    this.repetitionsPerSet,
    required this.muscleGroups,
    required this.requiredEquipment,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firestoreId': firestoreId,
      'sessionId': sessionId,
      'name': name,
      'description': description,
      'sets': sets,
      'repetitionsPerSet': repetitionsPerSet,
      'muscleGroups': jsonEncode(muscleGroups.map((group) => group.toString().split('.')[1]).toList()),
      'requiredEquipment': jsonEncode(requiredEquipment.map((group) => group.toString().split('.')[1]).toList()),
    }..removeWhere(
      (dynamic key, dynamic value) => value == null);
  }

  factory ExerciseSet.fromMap(Map<String, dynamic> map) {
    return ExerciseSet(
      id: map['id'] as int?,
      firestoreId: map['firestoreId'] as String?,
      sessionId: map['sessionId'] as int,
      name: map['name'] as String,
      sets: map['sets'] as int?,
      description: map['description'] as String?,
      repetitionsPerSet: map['repetitionsPerSet'] as int?,
      muscleGroups: (jsonDecode(map['muscleGroups']) as List)
          .map((e) => MuscleGroup.values.firstWhere(
            (muscle) => muscle.toString().split('.')[1] == e))
          .toList(),
      requiredEquipment: (jsonDecode(map['requiredEquipment']) as List)
          .map((e) =>
          Equipment.values.firstWhere(
            (equipment) => equipment.toString().split('.')[1] == e))
          .toList(),
    );
  }
}


enum MuscleGroup {
  anteriorDelts,
  biceps,
  calves,
  chest,
  core,
  forearms,
  glutes,
  hamstrings,
  lats,
  lowerBack,
  medialDelts,
  neck,
  other,
  posteriorDelts,
  quadriceps,
  triceps,
  upperBack,
}

enum Equipment {
  adjustableBench,
  barbell,
  cableMachine,
  curlBar,
  dumbbells,
  exerciseBall,
  flatBench,
  kettlebell,
  medicineBall,
  powerRack,
  pullUpBar,
  specializedMachine,
  other,
}
