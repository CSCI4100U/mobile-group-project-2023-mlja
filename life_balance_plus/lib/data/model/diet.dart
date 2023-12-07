import 'dart:convert';
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
  int? id;
  String? firestoreId;
  int dailyCals;
  DietType dietType;
  DateTime startDate;
  DateTime? endDate;
  Map<String, List<Meal>>? mealsHistory;
  Map<DateTime, List<String>>? notes;
  DietStatus? status;

  Diet({
    this.firestoreId,
    this.id,
    required this.dailyCals,
    required this.dietType,
    required this.startDate,
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
    String? dateStr = map['endDate'] as String?;
    DateTime? endDate_;
    if (dateStr != null) {
      endDate_ = DateTime.tryParse(dateStr);
    }

    return Diet(
      id: map['id'],
      firestoreId: map['firestoreId'],
      dailyCals: map['dailyCals'],
      dietType: DietType.values[map['dietType']],
      startDate: DateTime.parse(map['startDate']),
      endDate: endDate_,

      mealsHistory: jsonDecode(map['mealsHistory']).map((key, value) {
        return MapEntry(key, List<Map<String, dynamic>>.from(value).map((item) {
          return Meal.fromMap(item);
        }).toList());
      }),

      notes: jsonDecode(map['notes']).map((key, value) {
        return MapEntry(DateTime.parse(key), List<String>.from(value));
      }),

      status: DietStatus.values[map['status']],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> historyMap = {};
    Map<String, dynamic> notesMap = {};

    if (mealsHistory != null) {
      historyMap = mealsHistory!.map((key, value) {
        return MapEntry(key, value.map((item) => item.toMap()).toList());
      });
    }

    if (notes != null) {
      notesMap = notes!.map((key, value) {
        return MapEntry(key.toIso8601String(), value);
      });
    }

    String historyString = jsonEncode(historyMap);
    String notesString = jsonEncode(notesMap);

    return {
      'id': id,
      'firestoreId': firestoreId,
      'dailyCals': dailyCals,
      'dietType': dietType.index,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'mealsHistory': historyString,
      'notes': notesString,
      'status': status,
    }..removeWhere(
          (dynamic key, dynamic value) => value == null);
  }
}