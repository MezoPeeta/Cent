import 'package:cent/src/core/database/cent_database.dart';
import 'package:cent/src/core/model/transaction.dart';

class TransactionDao {
  final dbProvider = SavingsDatabaseProvider.dbProvider;
  String tableName = 'TRANSACTIONS';

  Future<List<Transaction>> getTransactions() async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> maps = await db!.rawQuery(
      'SELECT * FROM $tableName ORDER BY createdAT DESC',
    );
    if (maps.isNotEmpty) {
      return maps.map(Transaction.fromMap).toList();
    }
    return [];
  }

  Future<Transaction?> getTransaction(int id) async {
    final db = await dbProvider.database;
    final maps = await db!.query(tableName, where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Transaction.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;

    return db!.delete(tableName, where: 'id= ?', whereArgs: [id]);
  }

  Future<int> insert(Transaction expense) async {
    final db = await dbProvider.database;
    return db!.insert(tableName, expense.toMap());
  }

  Future<int> update(Transaction transaction) async {
    final db = await dbProvider.database;
    final foundTransactions = await getTransactions();
    for (final element in foundTransactions) {
      if (element.id == transaction.id) {}
      return db!.update(
        tableName,
        transaction.toMap(),
        where: 'id = ?',
        whereArgs: [transaction.id],
      );
    }
    return insert(transaction);
  }
}
