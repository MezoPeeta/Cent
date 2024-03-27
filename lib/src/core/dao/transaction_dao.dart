import 'package:cent/src/core/database/savings_database.dart';
import 'package:cent/src/core/model/transaction.dart';

class TransactionDao {
  final dbProvider = SavingsDatabaseProvider.dbProvider;
  String tableName = "TRANSACTIONS";

  Future<List<Transaction>> getTransaction() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> maps = await db!.rawQuery(
      "SELECT * FROM $tableName ORDER BY createdAT DESC",
    );
    if (maps.isNotEmpty) {
      return maps.map((e) => Transaction.fromMap(e)).toList();
    }
    return [];
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;

    return await db!.delete(tableName, where: 'id= ?', whereArgs: [id]);
  }

  Future<int> insert(Transaction expense) async {
    final db = await dbProvider.database;
    return await db!.insert(tableName, expense.toMap());
  }

  Future<int> update(Transaction expense) async {
    final db = await dbProvider.database;
    final foundGoals = await getTransaction();
    for (var element in foundGoals) {
      if (element.id == expense.id) {}
      return db!.update(tableName, expense.toMap(),
          where: 'id = ?', whereArgs: [expense.id]);
    }
    return insert(expense);
  }
}
