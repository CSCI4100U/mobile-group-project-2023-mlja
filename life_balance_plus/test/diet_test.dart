import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:life_balance_plus/data/model/diet.dart';
import 'package:life_balance_plus/data/model/meal.dart';

void main() {
  group('Diet', () {
    DateTime now = DateTime.now();
    test('addMeal should add a meal to mealsHistory', () {
      final diet = Diet(
        startDate: DateTime.now(),
        dailyCals: 2000,
        dietType:
        DietType.vegetarian
      );
      final meal = Meal(
          name: 'Breakfast',
          mealType: 'Breakfast',
      );

      final date = DateTime.now();
      final entryDate = DateFormat('yyyy-MM-dd').format(date);

      diet.addMeal(date, meal);

      expect(diet.mealsHistory, containsPair(entryDate, [meal]));
    });

    test('addNote should add a note to notes', () {
      final diet = Diet(
          dailyCals: 2000,
          dietType: DietType.vegetarian,
          startDate: DateTime.now(),
      );
      const String note = 'Remember to drink water';

      diet.addNote(note);

      expect(diet.notes, containsPair(DateTime.now(), [note]));
    });

    test('progressGraph should return a Container widget', () {
      final diet = Diet(dailyCals: 2000, dietType: DietType.vegetarian, startDate: DateTime.now());
      final startDate = DateTime(2023, 1, 1);
      final endDate = DateTime(2023, 1, 7);
      final metrics = ['weight', 'calories'];

      final graphWidget = diet.progressGraph(startDate, endDate, metrics);

      expect(graphWidget, isA<Container>());
    });

    test('start should set the status to active', () {
      final diet = Diet(dailyCals: 2000, dietType: DietType.vegetarian, startDate: DateTime.now());

      diet.start();

      expect(diet.status, equals(DietStatus.active));
    });

    test('pause should set the status to paused', () {
      final diet = Diet(dailyCals: 2000, dietType: DietType.vegetarian, startDate: DateTime.now());

      diet.pause();

      expect(diet.status, equals(DietStatus.paused));
    });

    test('finish should set the status to inactive', () {
      final diet = Diet(dailyCals: 2000, dietType: DietType.vegetarian, startDate: DateTime.now());

      diet.finish();

      expect(diet.status, equals(DietStatus.inactive));
    });

    test('fromMap should create a Diet instance from a map', () {
      final map = {
        'firestoreId': '123',
        'id': 1,
        'dailyCals': 2000,
        'dietType': DietType.vegetarian.index,
        'startDate': '2023-01-01',
        'endDate': '2023-01-07',
        'mealsHistory': {'2023-01-01': [{'name': 'Breakfast', 'calories': 500}]},
        'notes': {DateTime.now().toIso8601String(): ['Remember to drink water']},
        'status': DietStatus.active,
      };

      final diet = Diet.fromMap(map);

      expect(diet.firestoreId, equals('123'));
      expect(diet.id, equals(1));
      expect(diet.dailyCals, equals(2000));
      expect(diet.dietType, equals(DietType.vegetarian));
      expect(diet.startDate, equals(DateTime(2023, 1, 1)));
      expect(diet.endDate, equals(DateTime(2023, 1, 7)));
      expect(diet.mealsHistory, equals({'2023-01-01': [Meal(name: 'Breakfast', mealType: 'Breakfast')]}));
      expect(diet.notes, equals({DateTime.now(): ['Remember to drink water']}));
      expect(diet.status, equals(DietStatus.active));
    });

    test('toMap should convert a Diet instance to a map', () {
      final diet = Diet(
        firestoreId: '123',
        id: 1,
        dailyCals: 2000,
        dietType: DietType.vegetarian,
        startDate: DateTime(2023, 1, 1),
        endDate: DateTime(2023, 1, 7),
        mealsHistory: {'2023-01-01': [Meal(name: 'Breakfast', mealType: 'Breakfast')]},
        notes: {DateTime.now(): ['Remember to drink water']},
        status: DietStatus.active,
      );

      final map = diet.toMap();

      expect(map['firestoreId'], equals('123'));
      expect(map['id'], equals(1));
      expect(map['dailyCals'], equals(2000));
      expect(map['dietType'], equals(DietType.vegetarian.index));
      expect(map['startDate'], equals('2023-01-01'));
      expect(map['endDate'], equals('2023-01-07'));
      expect(map['mealsHistory'], equals({'2023-01-01': [Meal(name: 'Breakfast', mealType: 'Breakfast')]}));
      expect(map['notes'], equals({DateTime.now().toIso8601String(): ['Remember to drink water']}));
      expect(map['status'], equals(DietStatus.active));
    });
  });
}
