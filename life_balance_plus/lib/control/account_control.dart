import 'package:sqflite/sqflite.dart';
import 'dart:async';
import '../data/database_provider.dart';
import '../model/account.dart';

class AccountControl {

  Future<int> addAccount(Account account) async {
    final db = await DatabaseDriver.init();
    return db.insert(
        'account',
        account.toMap(),
        conflicAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future updateAccountInfo(Account account) async {
    final db = await DatabaseDriver.init();
    return db.update(
        'account',
        account.toMap(),
        where: 'id = ?',
        whereArgs: [account.id]
    );
  }

  Future deleteAccount(Account account) async {
    final db = await DatabaseDriver.init();
    int id = account.id!;
    await db.delete(
      'account',
      where: 'id = ?',
      whereArgs: [id]
    );
  }
}
