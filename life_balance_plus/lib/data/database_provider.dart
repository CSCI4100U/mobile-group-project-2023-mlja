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
      )'''
    );

    // Workout plan table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS workout_plans (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firestoreId TEXT,
        accountEmail TEXT,
        title TEXT,
        type TEXT,
        sessions TEXT,
        FOREIGN KEY (accountEmail) REFERENCES accounts (email)
      )'''
    );

    // Fitness log tables
    await db.execute('''
      CREATE TABLE IF NOT EXISTS session_logs(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firestoreId TEXT,
        accountEmail TEXT,
        date TEXT,
        notes TEXT,
        FOREIGN KEY (accountEmail) REFERENCES accounts (email)
      )'''
    );

    await db.execute('''
      CREATE TABLE IF NOT EXISTS set_logs(
        id INTEGER PRIMARY KEY,
        firestoreId TEXT,
        exerciseName TEXT,
        exerciseDescription TEXT,
        muscleGroups TEXT,
        requiredEquipment TEXT,
        reps INTEGER,
        weight REAL,
        duration REAL,
        avgSpeed REAL,
        session_log_id INTEGER,
        FOREIGN KEY (session_log_id) REFERENCES session_logs (id)
      )'''
    );

    // Meal tables
    await db.execute('''
      CREATE TABLE IF NOT EXISTS meals(
        id INTEGER PRIMARY KEY,
        name TEXT,
        mealType TEXT,
        fats REAL,
        proteins REAL,
        carbs REAL
      )'''
    );

    await db.execute('''
      CREATE TABLE IF NOT EXISTS diets(
        id INTEGER PRIMARY KEY,
        firestoreId TEXT
        dailyCals INTEGER,
        startDate TEXT,
        endDate TEXT,
        status TEXT
      )'''
    );

    await db.execute('''
      CREATE TABLE IF NOT EXISTS diets_meals(
        diet_id INTEGER NOT NULL,
        meal_id INTEGER NOT NULL,
        meal_date TEXT,
        FOREIGN KEY (diet_id) REFERENCES diets (id),
        FOREIGN KEY (meal_id) REFERENCES meals (id)
      )'''
    );
  }
}
