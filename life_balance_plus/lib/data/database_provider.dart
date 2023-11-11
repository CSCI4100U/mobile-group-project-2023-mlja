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

        await db.execute(
          '''
          CREATE TABLE IF NOT EXISTS diets(
            id INTEGER PRIMARY KEY,
            dailyCals INTEGER,
            startDate DATE,
            endDate DATE,
            status TEXT,
          )
          '''
        );

        await db.execute(
          '''
           CREATE TABLE IF NOT EXISTS diets_meals(
             diet_id INTEGER NOT NULL,
             meal_id INTEGER NOT NULL,
             meal_date DATE,
             FOREIGN KEY (diet_id) REFERENCES diets (id),
             FOREIGN KEY (meal_id) REFERENCES meals (id),
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
