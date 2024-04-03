import 'package:cent/src/core/dao/transaction_dao.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IconCubit extends Cubit<int> {
  IconCubit() : super(58136);

  Future<void> getDefault(int id) async {
    final transaction = await TransactionDao().getTransaction(id);
    emit(transaction!.icon);
  }

  void changeIcon(int newValue) {
    emit(newValue);
  }
}
