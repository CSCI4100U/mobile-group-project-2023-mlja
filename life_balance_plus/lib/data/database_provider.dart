import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;


class DatabaseDriver {
  static Future init() async {
    var database = openDatabase(
      path.join(await getDatabasesPath(), 'database_manager.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE IF NOT EXISTS exercises(id INTEGER PRIMARY KEY, name TEXT, sets INTEGER)'
        );
        await db.execute(
          '''
          CREATE TABLE IF NOT EXISTS meals(
            id INTEGER PRIMARY KEY,
            name TEXT,
            mealType TEXT,
            fats REAL,
            proteins REAL,
            carbs REAL
          )
          '''
        );
      },
      version: 1
    );

    print("Created DB $database");
    return database;
  }
}
