class FitnessLogs {
  List<SessionLog> entries;

  FitnessLogs({required this.entries});

  void addSessionEntry(SessionLog session) {
    entries.add(session);
  }
}


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
    required this.sets,
    required this.notes
  });

  factory SessionLog.fromMap(Map<String, dynamic> map) {
    return SessionLog(
      id: map['id'],
      firestoreId: map['firestoreId'],
      accountEmail: map['accountEmail'],
      date: DateTime.parse(map['date']),
      sets: map['sets'],
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
      'sets': sets,
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


abstract class SetLog {
  int? id;
  String? firestoreId;
  String exerciseName;

  SetLog({this.id, this.firestoreId, required this.exerciseName});

  
  Map<String, dynamic> toMap();
  Map<String, dynamic> toFirestoreMap();
}

class CardioSetLog extends SetLog {
  double duration;
  double avgSpeed;

  CardioSetLog({
    super.id,
    super.firestoreId,
    required super.exerciseName,
    required this.duration,
    required this.avgSpeed
  });

  factory CardioSetLog.fromMap(Map<String, dynamic> map) {
    return CardioSetLog(
      id: map['id'],
      firestoreId: map['firestoreId'],
      exerciseName: map['exerciseName'],
      duration: map['duration'],
      avgSpeed: map['avgSpeed'],
    );
  }

  Map<String, dynamic> toMap() {


    print('CARDIO SET LOG TO MAP CALLED');


    return {
      'id': id,
      'firestoreId': firestoreId,
      ...toFirestoreMap()
    };
  }

  Map<String, dynamic> toFirestoreMap() {


    print('CARDIO SET LOG TO FIRESTORE MAP CALLED');


    return {
      'exerciseName': exerciseName,
      'duration': duration,
      'avgSpeed': avgSpeed
    };
  }
}

class ResistanceSetLog extends SetLog {
  int reps;
  double weight;

  ResistanceSetLog({
    super.id,
    super.firestoreId,
    required super.exerciseName,
    required this.reps,
    required this.weight
  });

  factory ResistanceSetLog.fromMap(Map<String, dynamic> map) {
    return ResistanceSetLog(
      id: map['id'],
      firestoreId: map['firestoreId'],
      exerciseName: map['exerciseName'],
      reps: map['resp'],
      weight: map['weight'],
    );
  }

  Map<String, dynamic> toMap() {


    print('RESISTANCE SET LOG TO MAP CALLED');


    return {
      'id': id,
      'firestoreId': firestoreId,
      ...toFirestoreMap()
    };
  }

  Map<String, dynamic> toFirestoreMap() {


    print('RESISTANCE SET LOG TO FIRESTORE MAP CALLED');


    return {
      'exerciseName': exerciseName,
      'reps': reps,
      'weight': weight,
    };
  }
}
