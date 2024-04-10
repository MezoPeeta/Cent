// ignore_for_file: lines_longer_than_80_chars

import 'package:sqflite/sqflite.dart';

class SavingsDatabaseProvider {
  static final SavingsDatabaseProvider dbProvider = SavingsDatabaseProvider();

  Database? _database;



  Future<Database?> get database async => _database ??= await createDatabase();

  Future<Database> createDatabase() async {
    return openDatabase(
      'cent.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE USER(id INTEGER PRIMARY KEY, name TEXT, balance DOUBLE(100))',
        );
        await db.execute(
          'CREATE TABLE GOAL(id INTEGER PRIMARY KEY, name TEXT, amount DOUBLE(100), color int(100),icon int(100),createdAt DATE)',
        );
        await db.execute(
          'CREATE TABLE TRANSACTIONS(id INTEGER PRIMARY KEY, name TEXT, amount DOUBLE(100), icon int(100), type TEXT, createdAt DATE)',
        );
      },
    );
  }
}
