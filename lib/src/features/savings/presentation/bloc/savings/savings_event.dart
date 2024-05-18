part of 'savings_bloc.dart';

@immutable
sealed class SavingsEvent {}

final class LoadSavings extends SavingsEvent {}

final class EditSavings extends SavingsEvent {
  EditSavings(this.newValue);
  final double newValue;
}

final class EditUserSavings extends SavingsEvent {
  EditUserSavings(this.transactionAmount, {required this.isExpense});
  final double transactionAmount;
  final bool isExpense;
}

final class ChangeUserName extends SavingsEvent {
  ChangeUserName(this.name);
  final String name;
}

final class AddUserBalance extends SavingsEvent {
  AddUserBalance(this.balance);
  final double balance;
}

final class ResetUserBalance extends SavingsEvent {
  ResetUserBalance(this.transaction);

  final Transaction transaction;
}
