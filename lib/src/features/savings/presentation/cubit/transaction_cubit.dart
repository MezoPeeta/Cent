import 'package:cent/src/core/common/enums/transaction.dart';
import 'package:cent/src/core/dao/transaction_dao.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionCubit extends Cubit<TransactionType> {
  TransactionCubit() : super(TransactionType.expense);

  Future<void> getDefault(int? id) async {
    final transaction = await TransactionDao().getTransaction(id!);
    if (transaction!.type == 'income') {
      emit(TransactionType.income);
      return;
    }
    emit(TransactionType.expense);
  }

  void changeType(TransactionType newValue) {
    emit(newValue);
  }
}
