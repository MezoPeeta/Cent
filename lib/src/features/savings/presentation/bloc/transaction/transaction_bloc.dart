import 'package:cent/src/core/dao/transaction_dao.dart';
import 'package:cent/src/core/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, List<Transaction>> {
  TransactionBloc() : super([]) {
    on<LoadTransactionEvent>((event, emit) async {
      final transactions =
          await TransactionDao().getTransactions();
      emit(transactions);
    });
    on<AddTransactionEvent>((event, emit) async {
      await TransactionDao().insert(event.transaction);
      final transactions =
          await TransactionDao().getTransactions();

      emit(transactions);
    });
    on<EditTransaction>((event, emit) async {
      await TransactionDao().update(event.transaction);
      final transactions =
          await TransactionDao().getTransactions();

      emit(transactions);
    });
    on<DeleteTransactionEvent>((event, emit) async {
      await TransactionDao().delete(event.id);
      final transactions =
          await TransactionDao().getTransactions();

      emit(transactions);
    });
  }
}
