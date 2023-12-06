import 'package:life_balance_plus/data/database_provider.dart';
import 'package:life_balance_plus/data/model/account.dart';
import 'package:sqflite/sqflite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class AccountControl {
  static Future getAccounts() async {
    final Database db = await DatabaseProvider.instance.database;
    final List maps = await db.query('account');
    List<Account> result = [];
    for (int i = 0; i < maps.length; i++) {
      result.add(Account.fromMap(maps[i]));
    }
    return result;
  }

  static Future<Account?> loadAccount(String email) async {
    final Database db = await DatabaseProvider.instance.database;
    final List accountMap =
        await db.query('account', where: 'email = ?', whereArgs: [email]);
    if (accountMap.isNotEmpty) {
      return Account.fromMap(accountMap[0]);
    } else {
      return null;
    }
  }

  static Future<int> addAccount(Account account) async {
    final Database db = await DatabaseProvider.instance.database;
    return db.insert('account', account.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future updateAccount(Account account, [bool updateCloud=true]) async {
    if(updateCloud) _updateAccountCloud(account);
    return _updateAccountLocal(account);
  }

  static Future deleteAccount(Account account) async {
    final Database db = await DatabaseProvider.instance.database;
    await db.delete('account', where: 'email = ?', whereArgs: [account.email]);
  }

  static Future _updateAccountLocal(Account account) async {
    final Database db = await DatabaseProvider.instance.database;
    return db.update('account', account.toMap(),
        where: 'email = ?', whereArgs: [account.email]);
  }

  static void _updateAccountCloud(Account account) {
    FirebaseFirestore.instance.collection('users')
                              .doc(account.firestoreId)
                              .update(account.toFirestoreMap());
  }
}
