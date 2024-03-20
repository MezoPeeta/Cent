import 'package:cent/src/core/dao/savings_dao.dart';
import 'package:cent/src/core/model/user.dart';

abstract interface class SavingsRepository {
  final savingsDao = SavingsDao();

  Future<User?> getUser(int id) async => await savingsDao.getUser();

  Future<int> delete(int id) async => await savingsDao.delete(id);

  Future<void> close() async => await savingsDao.close();
}
