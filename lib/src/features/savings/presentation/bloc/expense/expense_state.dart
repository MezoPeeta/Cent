part of 'expense_bloc.dart';

@immutable
sealed class ExpenseState {}

final class ExpenseInitial extends ExpenseState {
  final List<Expense> expenses;
  ExpenseInitial({this.expenses = const []});
}
