import 'package:cent/src/core/dao/savings_dao.dart';
import 'package:cent/src/core/dao/transaction_dao.dart';
import 'package:cent/src/core/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    on<LoadTransactionEvent>((event, emit) async {
      final transactions = await TransactionDao().getTransactions();
      emit(TransactionInitial(transactions: transactions));
    });
    on<AddTransactionEvent>((event, emit) async {
      final user = await SavingsDao().getUser();
      final currentTransactions = await TransactionDao().getTransactions();

      if (user.balance < event.transaction.amount &&
          event.transaction.type == 'expense') {
        emit(
          TransactionError(
            message:
                "User doesn't has enough balance, try to edit your balance",
          ),
        );
        emit(TransactionInitial(transactions: currentTransactions));

        return;
      }

      await TransactionDao().insert(event.transaction);
      final newTransactions = await TransactionDao().getTransactions();

      emit(TransactionInitial(transactions: newTransactions));
    });
    on<EditTransaction>((event, emit) async {
      await TransactionDao().update(event.transaction);
      final transactions = await TransactionDao().getTransactions();

      emit(TransactionInitial(transactions: transactions));
    });
    on<DeleteTransactionEvent>((event, emit) async {
      await TransactionDao().delete(event.id);
      final transactions = await TransactionDao().getTransactions();

      emit(TransactionInitial(transactions: transactions));
    });
    on<DeleteAllTransactionGoalsEvent>((event, emit) async {
      final currentTransactions = await TransactionDao().getTransactions();
      final goalTransaction = currentTransactions
          .where((element) => element.goalID == event.goalID);
      for (final element in goalTransaction) {
        await TransactionDao().delete(element.id!);
      }
      final newTransactions = await TransactionDao().getTransactions();

      emit(TransactionInitial(transactions: newTransactions));
    });
  }
}
