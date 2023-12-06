import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'meal.dart';

enum DietType {
  vegetarian,
  vegan,
  keto,
  paleo,
  other,
}

enum DietStatus {
  active,
  paused,
  inactive,
}

class Diet {
  String? firestoreId;
  int? id;
  int dailyCals;
  DietType dietType;
  DateTime? startDate;
  DateTime? endDate;
  Map<String, List<Meal>>? mealsHistory;
  Map<DateTime, List<String>>? notes;
  DietStatus? status;

  Diet({
    this.firestoreId,
    this.id,
    required this.dailyCals,
    required this.dietType,
    this.startDate,
    this.endDate,
    this.mealsHistory,
    this.notes,
    this.status,
  });

  void addMeal(DateTime date, Meal meal) {
    final entryDate = DateFormat('yyyy-MM-dd').format(date);

    // initialize mealsHistory if it is still null
    mealsHistory ??= {};

    if (mealsHistory!.containsKey(entryDate)) {
      mealsHistory![entryDate]!.add(meal);
    } else {
      mealsHistory![entryDate] = [meal];
    }
  }

  void addNote(String note){
    final date = DateTime.now();

    // Initialize notes if it is still null
    notes ??= {};

    if (notes!.containsKey(date)) {
      notes![date]!.add(note);
    } else {
      notes![date] = [note];
    }
  }

  Widget progressGraph(DateTime startDate, DateTime endDate, List<String> metrics) {
    return Container(
      child: Text("Placeholder Graph"),
    );
  }

  void start() => status = DietStatus.active;
  void pause() => status = DietStatus.paused;
  void finish() => status = DietStatus.inactive;

  factory Diet.fromMap(Map<String, dynamic> map) {
    return Diet(
      firestoreId: map['firestoreId'],
      id: map['id'],
      dailyCals: map['dailyCals'],
      dietType: DietType.values[map['dietType']],
      startDate: DateTime.tryParse(map['startDate']),
      endDate: DateTime.tryParse(map['endDate']),
      mealsHistory: map['mealsHistory'],
      notes: map['notes'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firestoreId': firestoreId,
      'id': id,
      'dailyCals': dailyCals,
      'dietType': dietType.index,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'mealsHistory': mealsHistory,
      'notes': notes,
      'status': status,
    };
  }
}