import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import '../data/database_provider.dart';
import '../data/model/diet.dart';
import 'package:life_balance_plus/data/model/session.dart';

class DietControl {
  final userId = Session.instance.account!.firestoreId;

  Future<List<Diet>> getAllDiets() async {
    final Database db = await DatabaseProvider.instance.database;
    List<Diet> result;
    final List localData = await db.query('diets');
    if (localData.isNotEmpty) {
      result = localData.map((e) => Diet.fromMap(e)).toList();
    } else {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
          .instance
          .collection('diets')
          .where('userId', isEqualTo: userId)
          .get();
      final documents = querySnapshot.docs;

      List<Map<String, dynamic>> remoteData = documents.map((e) =>
          e.data()).toList();
      result = remoteData.map((e) => Diet.fromMap(e)).toList();
    }

    return result;
  }

  Future<void> addDiet(Diet diet) async {
    final Database db = await DatabaseProvider.instance.database;
    diet.id = await db.insert(
        'diets',
        diet.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
    _addCloudDiet(diet);
  }

  Future _addCloudDiet(Diet diet) async {
    final ref = FirebaseFirestore.instance.collection('diets').doc();
    try {
      ref.set(
        {
          ...diet.toMap(),
          'userId': userId,
        }
      );
    } catch (e) {
      print("Error adding Diet to Firestore: $e");
    }
  }

  Future addDietsMult(List<Diet> diets) async {
    await Future.forEach(diets, (Diet diet) async {
      await addDiet(diet);
    });
  }

  Future<void> updateDiet(Diet diet) async {
    final Database db = await DatabaseProvider.instance.database;
    db.update(
        'diets',
        diet.toMap(),
        where: 'id = ?',
        whereArgs: [diet.id]);
    _updateCloudDiet(diet);
  }

  Future _updateCloudDiet(Diet diet) async {
    FirebaseFirestore.instance.collection('diets')
        .doc(diet.firestoreId).update(diet.toMap());
  }

  Future deleteDiet(Diet diet) async {
    final Database db = await DatabaseProvider.instance.database;
    await db.delete('diets', where: 'id = ?', whereArgs: [diet.id]);
    await _deleteCloudDiet(diet);
  }

  Future _deleteCloudDiet(Diet diet) async {
    FirebaseFirestore.instance.collection('diets')
        .doc(diet.firestoreId).delete()
        .then((_) {
          print('Diet deleted from Firestore: $diet');
      }).catchError((e) {
        print("Error deleting diet from Firestore: $e");
    });
  }
}
