import 'dart:io';
import 'package:path/path.dart'; // ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const String _dbFileName = 'database.db';
  static const int _dbVersion = 1;
  static Database? _database;

  // Private constructor
  DatabaseProvider._();

  // Singleton instance
  static final DatabaseProvider instance = DatabaseProvider._();

  Future<Database> get database async {
    return _database ??= await _initDb();
  }

  Future<Database> _initDb() async {
    final dbDirectory = Platform.isAndroid
        ? await getApplicationDocumentsDirectory()
        : await getLibraryDirectory();
    final String dbPath = join(dbDirectory.path, _dbFileName);
    return await openDatabase(
      dbPath,
      version: _dbVersion,
      onCreate: _create,
    );
  }

  Future<void> _create(Database db, int version) async {
    // Account table
    await db.execute('''
          CREATE TABLE IF NOT EXISTS account(
            email TEXT PRIMARY KEY,
            firestoreId TEXT,
            firstName TEXT,
            lastName TEXT,
            height REAL,
            weight REAL,
            gender TEXT,
            dateOfBirth TEXT,
            caloricIntakeGoal INTEGER,
            dailyActivityGoal INTEGER,
            waterIntakeGoal INTEGER,
            unitsSystem TEXT,
            useNotifications INTEGER,
            notificationSound INTEGER,
            notificationVibration INTEGER,
            notificationFrequency INTEGER,
            useWifi INTEGER,
            useMobileData INTEGER,
            useBluetooth INTEGER,
            useNFC INTEGER,
            useLocation INTEGER
          )''');

    // Exercise table
    await db.execute('''
        CREATE TABLE IF NOT EXISTS workout_plans (
          planId INTEGER PRIMARY KEY AUTOINCREMENT,
          firestoreId TEXT,
          title TEXT,
          startDate TEXT,
          endDate TEXT,
          type TEXT,
          sessions TEXT
          )''');

    await db.execute('''
        CREATE TABLE IF NOT EXISTS workout_sessions (
          sessionId INTEGER PRIMARY KEY AUTOINCREMENT,
          firestoreId TEXT,
          planId INTEGER,
          date TEXT,
          exercises TEXT,
          FOREIGN KEY (planId) REFERENCES workout_plans (planId)
        )
          ''');

    await db.execute('''
        CREATE TABLE IF NOT EXISTS exercise_sets (
          id INTEGER PRIMARY KEY AUTOINCREMENT ,
          firestoreId TEXT,
          name TEXT,
          description TEXT,
          sets INTEGER,
          repetitionsPerSet INTEGER,
          sessionId INTEGER,
          muscleGroups TEXT,
          requiredEquipment TEXT,
          FOREIGN KEY (sessionId) REFERENCES workout_sessions (sessionId)
          )''');


    // Meal table
    await db.execute('''
          CREATE TABLE IF NOT EXISTS meals(
            id INTEGER PRIMARY KEY,
            name TEXT,
            mealType TEXT,
            fats REAL,
            proteins REAL,
            carbs REAL
          )''');

    await db.execute('''
          CREATE TABLE IF NOT EXISTS diets(
            id INTEGER PRIMARY KEY,
            firestoreId TEXT
            dailyCals INTEGER,
            startDate TEXT,
            endDate TEXT,
            status TEXT
          )''');

    await db.execute('''
           CREATE TABLE IF NOT EXISTS diets_meals(
             diet_id INTEGER NOT NULL,
             meal_id INTEGER NOT NULL,
             meal_date TEXT,
             FOREIGN KEY (diet_id) REFERENCES diets (id),
             FOREIGN KEY (meal_id) REFERENCES meals (id)
           )''');


    // Fitness log tables
    await db.execute(
        'CREATE TABLE IF NOT EXISTS fitness_logs(id INTEGER PRIMARY KEY)');

    await db.execute('''
          CREATE TABLE IF NOT EXISTS session_logs(
            id INTEGER PRIMARY KEY,
            date TEXT,
            fitness_log_id INTEGER,
            FOREIGN KEY (fitness_log_id) REFERENCES fitness_logs (id)
          )''');

    await db.execute('''
          CREATE TABLE IF NOT EXISTS set_logs(
            id INTEGER PRIMARY KEY,
            exercise_name TEXT,
            reps INTEGER,
            weight REAL,
            duration REAL,
            avgSpeed REAL,
            session_log_id INTEGER,
            FOREIGN KEY (session_log_id) REFERENCES session_logs (id)
          )''');
  }
}
