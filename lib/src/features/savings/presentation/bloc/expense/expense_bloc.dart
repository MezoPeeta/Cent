import 'package:cent/src/core/dao/expense_dao.dart';
import 'package:cent/src/core/model/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, List<Expense>> {
  ExpenseBloc() : super([]) {
    on<LoadExpenseEvent>((event, emit) async {
      final List<Expense> expenses = await ExpenseDao().getExpenses();
      emit(expenses);
    });
    on<AddExpenseEvent>((event, emit) async {
      await ExpenseDao().insert(event.expense);
      final List<Expense> expenses = await ExpenseDao().getExpenses();

      emit(expenses);
    });
  }
}
