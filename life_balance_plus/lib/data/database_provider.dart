import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DatabaseDriver {
  static Future init() async {
    var database = openDatabase(
      path.join(await getDatabasesPath(), 'database_manager.db'),
      onCreate: (db, version) async {
        // Account table
        await db.execute('''
          CREATE TABLE IF NOT EXISTS account(
            email TEXT PRIMARY KEY,
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

        // Exercise table
        await db.execute(
          'CREATE TABLE IF NOT EXISTS exercises(id INTEGER PRIMARY KEY, name TEXT, sets INTEGER)'
        );

        // Meal table
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
            dailyCals INTEGER,
            startDate DATE,
            endDate DATE,
            status TEXT
          )'''
        );

        await db.execute('''
           CREATE TABLE IF NOT EXISTS diets_meals(
             diet_id INTEGER NOT NULL,
             meal_id INTEGER NOT NULL,
             meal_date DATE,
             FOREIGN KEY (diet_id) REFERENCES diets (id),
             FOREIGN KEY (meal_id) REFERENCES meals (id)
           )'''
        );

        // Workout plan tables
        await db.execute('''
          CREATE TABLE IF NOT EXISTS workout_plans(
            id INTEGER PRIMARY KEY
          )'''
        );
        await db.execute('''
          CREATE TABLE IF NOT EXISTS sessions(
            id INTEGER PRIMARY KEY,
            date DATE
          )'''
        );
        await db.execute('''
          CREATE TABLE IF NOT EXISTS exercise_plans(
            id INTEGER PRIMARY KEY,
            name TEXT,
            sets INTEGER
          )'''
        );
        await db.execute('''
          CREATE TABLE IF NOT EXISTS session_exercises(
            exercise_id INTEGER NOT NULL,
            session_id INTEGER NOT NULL,
            FOREIGN KEY (exercise_id) REFERENCES exercise_plans (id),
            FOREIGN KEY (session_id) REFERENCES sessions (id)
          )'''
        );
        await db.execute('''
          CREATE TABLE IF NOT EXISTS workout_sessions(
            workout_plan_id INTEGER NOT NULL,
            session_id INTEGER NOT NULL,
            FOREIGN KEY (workout_plan_id) REFERENCES workout_plans (id),
            FOREIGN KEY (session_id) REFERENCES sessions (id)
          )'''
        );

        // Fitness log tables
        await db.execute('CREATE TABLE IF NOT EXISTS fitness_logs(id INTEGER PRIMARY KEY)');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS session_logs(
            id INTEGER PRIMARY KEY,
            date DATE,
            fitness_log_id INTEGER,
            FOREIGN KEY (fitness_log_id) REFERENCES fitness_logs (id)
          )'''
        );
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
          )'''
        );
      },

      version: 1
    );

    print("Created DB $database");
    return database;
  }
}
