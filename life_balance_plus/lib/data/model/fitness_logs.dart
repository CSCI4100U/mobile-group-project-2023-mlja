import 'package:life_balance_plus/data/model/session.dart';

class FitnessLogs {
  List<SessionLog> entries;

  FitnessLogs({required this.entries});

  void addSessionEntry(SessionLog session) {
    entries.add(session);
  }
}


class SessionLog {
  int? id;
  DateTime date;
  List<SetLog> sets;
  List<String> notes;

  SessionLog({this.id, required this.date, required this.sets, required this.notes});

  factory SessionLog.fromMap(Map<String, dynamic> map) {
    return SessionLog(
      id: map['id'],
      date: DateTime.parse(map['date']),
      sets: map['sets'],
      notes: map['notes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'sets': sets,
      'notes': notes,
    };
  }
}


abstract class SetLog {
  int? id;
  String exerciseName;

  SetLog({this.id, required this.exerciseName});
}

class CardioSetLog extends SetLog {
  double duration;
  double avgSpeed;

  CardioSetLog({super.id, required super.exerciseName, required this.duration, required this.avgSpeed});

  factory CardioSetLog.fromMap(Map<String, dynamic> map) {
    return CardioSetLog(
      id: map['id'],
      exerciseName: map['exerciseName'],
      duration: map['duration'],
      avgSpeed: map['avgSpeed'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'exerciseName': exerciseName,
      'duration': duration,
      'avgSpeed': avgSpeed
    };
  }
}

class ResistanceSetLog extends SetLog {
  int reps;
  double weight;

  ResistanceSetLog({super.id, required super.exerciseName, required this.reps, required this.weight});

  factory ResistanceSetLog.fromMap(Map<String, dynamic> map) {
    return ResistanceSetLog(
      id: map['id'],
      exerciseName: map['exerciseName'],
      reps: map['resp'],
      weight: map['weight'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'exerciseName': exerciseName,
      'reps': reps,
      'weight': weight,
    };
  }
}
