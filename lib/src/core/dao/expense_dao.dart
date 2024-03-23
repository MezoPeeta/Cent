import 'package:cent/src/core/database/savings_database.dart';
import 'package:cent/src/core/model/expense.dart';

class ExpenseDao {
  final dbProvider = SavingsDatabaseProvider.dbProvider;
  String tableName = "EXPENSE";

  Future<List<Expense>> getExpenses() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> maps = await db!.rawQuery(
      "SELECT * FROM $tableName ORDER BY createdAT DESC",
    );
    if (maps.isNotEmpty) {
      return maps.map((e) => Expense.fromMap(e)).toList();
    }
    return [];
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;

    return await db!.delete(tableName, where: 'id= ?', whereArgs: [id]);
  }

  Future<int> insert(Expense expense) async {
    final db = await dbProvider.database;
    return await db!.insert(tableName, expense.toMap());
  }

  Future<int> update(Expense expense) async {
    final db = await dbProvider.database;
    final foundGoals = await getExpenses();
    for (var element in foundGoals) {
      if (element.id == expense.id) {}
      return db!.update(tableName, expense.toMap(),
          where: 'id = ?', whereArgs: [expense.id]);
    }
    return insert(expense);
  }
}
