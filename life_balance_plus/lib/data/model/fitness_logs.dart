import 'package:life_balance_plus/data/model/exercise.dart';
import 'package:life_balance_plus/data/enums/equipment.dart';
import 'package:life_balance_plus/data/enums/muscle_group.dart';


/// Records of training history.
class FitnessLogs {
  List<SessionLog> entries;

  FitnessLogs({required this.entries});

  void addSessionEntry(SessionLog session) {
    entries.add(session);
  }
}


/// Record of a workout session.
class SessionLog {
  int? id;
  String? firestoreId;
  String accountEmail;
  DateTime date;
  List<SetLog> sets;
  List<String> notes;   // List of notes for additional info about session; must not contain \n

  SessionLog({
    this.id,
    this.firestoreId,
    required this.accountEmail,
    required this.date,
    List<SetLog>? sets,
    List<String>? notes
  }) : this.notes = notes ?? [],  this.sets = sets ?? [];

  factory SessionLog.fromMap(Map<String, dynamic> map) {
    return SessionLog(
      id: map['id'],
      firestoreId: map['firestoreId'],
      accountEmail: map['accountEmail'],
      date: DateTime.parse(map['date']),
      notes: map['notes'].split('\n'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firestoreId': firestoreId,
      ...toFirestoreMap()
    };
  }

  Map<String, dynamic> toFirestoreMap() {
    return {
      'id': id,
      'accountEmail': accountEmail,
      'date': date.toString(),
      'notes': notes.fold('', (str, note) => '$str$note\n'),
    };
  }

  void addSet(SetLog set) {
    sets.add(set);
  }

  void addNote(String note) {
    notes.add(note.replaceAll('\n', ' '));
  }
}


/// Record of a set in a workout session.
abstract class SetLog {
  int? id;
  String? firestoreId;
  Exercise exercise;

  SetLog({this.id, this.firestoreId, required this.exercise});

  
  Map<String, dynamic> toMap();
  Map<String, dynamic> toFirestoreMap();
}

class CardioSetLog extends SetLog {
  double duration;
  double avgSpeed;

  CardioSetLog({
    super.id,
    super.firestoreId,
    required super.exercise,
    required this.duration,
    required this.avgSpeed
  });

  factory CardioSetLog.fromMap(Map<String, dynamic> map) {
    return CardioSetLog(
      id: map['id'],
      firestoreId: map['firestoreId'],
      duration: map['duration'],
      avgSpeed: map['avgSpeed'],
      exercise: Exercise(
        name: map['exerciseName'],
        description: map['exerciseDescription'],
        muscleGroups: (map['muscleGroups'] == '')? []
          : (map['muscleGroups']
              .split(',')
              .where((str) => str != '')
              .map((group) => MuscleGroup.values.byName(group))
              .toList().cast<MuscleGroup>()
            ),
        requiredEquipment: (map['requiredEquipment'] == '')? []
          : (map['requiredEquipment']
              .split(',')
              .where((str) => str != '')
              .map((equipment) => Equipment.values.byName(equipment))
              .toList().cast<Equipment>()
            ),
      )
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firestoreId': firestoreId,
      ...toFirestoreMap()
    };
  }

  Map<String, dynamic> toFirestoreMap() {
    return {
      'exerciseName': exercise.name,
      'exerciseDescription': exercise.description,
      'muscleGroups': exercise.muscleGroups.fold(
        '', (str, group) => '$str${group.name},'
      ),
      'requiredEquipment': exercise.requiredEquipment.fold(
        '', (str, equipment) => '$str${equipment.name},'
      ),
      'duration': duration,
      'avgSpeed': avgSpeed,
      'reps': null,
      'weight': null,
    };
  }
}

class ResistanceSetLog extends SetLog {
  int reps;
  double? weight;   // Nullable for bodyweight exercises

  ResistanceSetLog({
    super.id,
    super.firestoreId,
    required super.exercise,
    required this.reps,
    this.weight
  });

  factory ResistanceSetLog.fromMap(Map<String, dynamic> map) {
    return ResistanceSetLog(
      id: map['id'],
      firestoreId: map['firestoreId'],
      reps: map['reps'],
      weight: map['weight'],
      exercise: Exercise(
        name: map['exerciseName'],
        description: map['exerciseDescription'],
        muscleGroups: (map['muscleGroups'] == '')? []
          : (map['muscleGroups']
              .split(',')
              .where((str) => str != '')
              .map((group) => MuscleGroup.values.byName(group))
              .toList().cast<MuscleGroup>()
            ),
        requiredEquipment: (map['requiredEquipment'] == '')? []
          : (map['requiredEquipment']
              .split(',')
              .where((str) => str != '')
              .map((equipment) => Equipment.values.byName(equipment))
              .toList().cast<Equipment>()
            ),
      )
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firestoreId': firestoreId,
      ...toFirestoreMap()
    };
  }

  Map<String, dynamic> toFirestoreMap() {
    return {
      'exerciseName': exercise.name,
      'exerciseDescription': exercise.description,
      'muscleGroups': exercise.muscleGroups.fold(
        '', (str, group) => '$str${group.name},'
      ),
      'requiredEquipment': exercise.requiredEquipment.fold(
        '', (str, equipment) => '$str${equipment.name},'
      ),
      'reps': reps,
      'weight': weight,
      'duration': null,
      'avgSpeed': null
    };
  }
}
