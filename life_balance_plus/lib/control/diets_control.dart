import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import '../data/database_provider.dart';
import '../data/model/diet.dart';
import '../data/model/account.dart';

class DietControl {
  Future<List<Diet>> getAllDiets() async {
    final Database db = await DatabaseProvider.instance.database;
    final List maps = await db.query('diets');
    List<Diet> result = [];
    for (int i = 0; i < maps.length; i++) {
      result.add(Diet.fromMap(maps[i]));
    }
    return result;
  }

  // TODO: find way to get account.firestoreId. Probably convert Account to singleton
  // Future getCloudDiets() async {
  //   return await FirebaseFirestore
  //       .instance
  //       .collection('diets')
  //       .where('userId', isEqualTo: Account.firestoreId)
  // }

  Future<int> addDiet(Diet diet) async {
    addCloudDiet(diet);
    final Database db = await DatabaseProvider.instance.database;
    return db.insert('diets', diet.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future addCloudDiet(Diet diet) async {
    final ref = FirebaseFirestore.instance.collection('diets').doc();
    try {
      ref.set(diet.toMap());
    } catch (e) {
      print("Error adding Diet to Firestore: $e");
    }
  }

  Future addDietsMult(List<Diet> diets) async {
    final Database db = await DatabaseProvider.instance.database;
    // diets.forEach((diet) {
    //   db.insert('diets', diet.toMap(),
    //       conflictAlgorithm: ConflictAlgorithm.replace);
    // });
    await Future.forEach(diets, (Diet diet) async {
      await db.insert('diets', diet.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
      await addCloudDiet(diet);
    });
  }

  Future updateDiet(Diet diet) async {
    final Database db = await DatabaseProvider.instance.database;
    return db
        .update('diets', diet.toMap(), where: 'id = ?', whereArgs: [diet.id]);
  }

  Future updateCloudDiet(Diet diet) async {
    FirebaseFirestore.instance.collection('diets')
        .doc(diet.id!.toString()).update(diet.toMap());
  }

  Future deleteDiet(Diet diet) async {
    final Database db = await DatabaseProvider.instance.database;
    await db.delete('diets', where: 'id = ?', whereArgs: [diet.id]);
    await deleteCloudDiet(diet);
  }

  Future deleteCloudDiet(Diet diet) async {
    FirebaseFirestore.instance.collection('diets')
        .doc(diet.firestoreId).delete()
        .then((_) {
          print('Diet deleted from Firestore: $diet');
      }).catchError((e) {
        print("Error deleting diet from Firestore: $e");
    });
  }
}
