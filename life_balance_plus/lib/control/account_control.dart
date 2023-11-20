import 'package:life_balance_plus/data/database_provider.dart';
import 'package:life_balance_plus/data/model/account.dart';
import 'package:sqflite/sqflite.dart';
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
    }
  }

  static Future<int> addAccount(Account account) async {
    final Database db = await DatabaseProvider.instance.database;
    return db.insert('account', account.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future updateAccountInfo(Account account) async {
    final Database db = await DatabaseProvider.instance.database;
    return db.update('account', account.toMap(),
        where: 'id = ?', whereArgs: [account.id]);
  }

  static Future deleteAccount(Account account) async {
    final Database db = await DatabaseProvider.instance.database;
    int id = account.id!;
    await db.delete('account', where: 'id = ?', whereArgs: [id]);
  }
}
