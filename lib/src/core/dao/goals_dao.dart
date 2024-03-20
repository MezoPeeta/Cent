import 'package:cent/src/core/database/savings_database.dart';
import 'package:cent/src/core/model/goal.dart';

class GoalDao {
  final dbProvider = SavingsDatabaseProvider.dbProvider;
  String tableName = "GOAL";

  Future<List<Goal>> getGoals() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> maps = await db!.rawQuery(
      "SELECT * FROM $tableName ORDER BY createdAT DESC",
    );
    if (maps.isNotEmpty) {
      return maps.map((e) => Goal.fromMap(e)).toList();
    }
    return [];
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;

    return await db!.delete(tableName, where: 'id= ?', whereArgs: [id]);
  }

  Future<int> insert(Goal goal) async {
    final db = await dbProvider.database;
    return await db!.insert(tableName, goal.toMap());
  }

  Future<int> update(Goal goal) async {
    final db = await dbProvider.database;
    final foundGoals = await getGoals();
    for (var element in foundGoals) {
      if (element.id == goal.id) {}
      return db!.update(tableName, goal.toMap(),
          where: 'id = ?', whereArgs: [goal.id]);
    }
    return insert(goal);
  }
}
