import 'package:sqflite/sqflite.dart';

class SavingsDatabaseProvider {
  static final SavingsDatabaseProvider dbProvider = SavingsDatabaseProvider();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  Future<Database> createDatabase() async {
    return await openDatabase(
      "cent.db",
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE USER(id INTEGER PRIMARY KEY, name TEXT, balance DOUBLE(100))');
        await db.execute(
            'CREATE TABLE GOAL(id INTEGER PRIMARY KEY, name TEXT, amount DOUBLE(100), color int(100),icon int(100),createdAt DATE)');
      },
    );
  }
}
