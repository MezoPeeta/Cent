import 'package:cent/src/core/database/savings_database.dart';

import 'package:cent/src/core/model/user.dart';

class SavingsDao {
  final dbProvider = SavingsDatabaseProvider.dbProvider;
  String tableName = 'USER';

  Future<User> getUser() async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> maps =
        await db!.query(tableName, columns: ['id', 'name', 'balance']);
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return User(
      id: 0,
      name: '',
      balance: 0,
    );
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;

    return db!.delete(tableName, where: 'id= ?', whereArgs: [id]);
  }

  Future<int> insert(User user) async {
    final db = await dbProvider.database;
    return db!.insert(tableName, user.toMap());
  }

  Future<void> close() async {
    final db = await dbProvider.database;

    return db!.close();
  }

  Future<int> update(User user) async {
    final db = await dbProvider.database;
    final foundUser = await getUser();
    if (foundUser.id == user.id) {
      return db!.update(
        tableName,
        user.toMap(),
        where: 'id = ?',
        whereArgs: [user.id],
      );
    }
    return insert(user);
  }
}
