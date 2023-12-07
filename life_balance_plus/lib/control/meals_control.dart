import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_balance_plus/data/database_provider.dart';
import 'package:life_balance_plus/data/model/meal.dart';
import 'package:life_balance_plus/data/model/session.dart';

class MealControl {
  final userId = Session.instance.account!.firestoreId;

  Future addDummyData() async {
    // Test list of Meals
    List<Meal> mealList = [
      Meal(
          name: 'Protein Bar',
          mealType: 'snack',
          fats: 12.5,
          proteins: 8.0,
          carbs: 3.5),
      Meal(
          name: 'Omelette',
          mealType: 'breakfast',
          fats: 15.0,
          proteins: 20.0,
          carbs: 2.0),
      Meal(
          name: 'Green Salad',
          mealType: 'lunch',
          fats: 5.0,
          proteins: 2.0,
          carbs: 10.0),
      Meal(
          name: 'Grilled Chicken',
          mealType: 'dinner',
          fats: 8.0,
          proteins: 25.0,
          carbs: 0.5),
      Meal(
          name: 'Greek Yogurt',
          mealType: 'snack',
          fats: 2.5,
          proteins: 15.0,
          carbs: 6.0),
      Meal(
          name: 'Chocolate Cake',
          mealType: 'dessert',
          fats: 20.0,
          proteins: 5.0,
          carbs: 30.0),
    ];

    await addMealsMult(mealList);
  }

  Future<List<Meal>> getAllMeals() async {
    final Database db = await DatabaseProvider.instance.database;
    List<Meal> result;
    final List localData = List.from(await db.query('meals'));
    if (localData.isNotEmpty) {
      result = localData.map((e) => Meal.fromMap(e)).toList();
    } else {
      final QuerySnapshot<
          Map<String, dynamic>> querySnapshot = await FirebaseFirestore
          .instance
          .collection('meals')
          .where('userId', isEqualTo: userId)
          .get();
      final documents = querySnapshot.docs;

      List<Map<String, dynamic>> remoteData = documents.map((diet) {
        return {
          ...diet.data(),
          'firestoreId': diet.id,
        };
      }).toList();
      result = remoteData.map((e) => Meal.fromMap(e)).toList();
    }
    return result;
  }

  Future<void> addMeal(Meal meal) async {
    final Database db = await DatabaseProvider.instance.database;
    meal.id = await db.insert('meals', meal.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    _addCloudMeal(meal);
  }

  Future _addCloudMeal(Meal meal) async {
    final ref = FirebaseFirestore.instance.collection('meals').doc();
    try {
      ref.set(
          {
            ...meal.toMap(),
            'userId': userId,
          }
      );
      meal.firestoreId = ref.id;
      updateMeal(meal);
    } catch (e) {
      print("Error adding Meal to Firestore: $e");
    }
  }

  Future addMealsMult(List<Meal> meals) async {
    await Future.forEach(meals, (Meal meal) async {
      await addMeal(meal);
    });
  }

  Future updateMeal(Meal meal) async {
    final Database db = await DatabaseProvider.instance.database;
    db.update(
        'meals',
        meal.toMap(),
        where: 'id = ?',
        whereArgs: [meal.id]
    );
    _updateCloudMeal(meal);
  }

  Future _updateCloudMeal(Meal meal) async {
    FirebaseFirestore.instance.collection('meals')
        .doc(meal.firestoreId)
        .update(meal.toMap()
    );
  }

  Future deleteMeal(Meal meal) async {
    final Database db = await DatabaseProvider.instance.database;
    await db.delete('meals', where: 'id = ?', whereArgs: [meal.id]);
    await _deleteCloudMeal(meal);
  }

  Future<void> _deleteCloudMeal(Meal meal) async {
    FirebaseFirestore.instance.collection('meals')
        .doc(meal.firestoreId) .delete()
        .then((_) {
          print("Meal deleted successfully");
      }).catchError((e) {
        print("Error deleting Meal: $e");
      });
  }
}
