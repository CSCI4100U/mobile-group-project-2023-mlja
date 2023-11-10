import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;


class DatabaseDriver {
  String dbURI;
  late Future<Database> database;

  DatabaseDriver({required this.dbURI}) { initDatabase(); }

  void initDatabase() async {
    this.database = openDatabase(
      path.join(await getDatabasesPath(), dbURI),
      onCreate: (db, version) {
        // create table
      },
      version: 1,
    );
  }
}
