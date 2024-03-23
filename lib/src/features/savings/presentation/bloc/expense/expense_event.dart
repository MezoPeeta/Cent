part of 'expense_bloc.dart';

@immutable
sealed class ExpenseEvent {}

final class LoadExpenseEvent extends ExpenseEvent {}

final class AddExpenseEvent extends ExpenseEvent {
  final Expense expense;

  AddExpenseEvent(this.expense);
}
