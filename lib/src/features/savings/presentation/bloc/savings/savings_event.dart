part of 'savings_bloc.dart';

@immutable
sealed class SavingsEvent {}

final class LoadSavings extends SavingsEvent {}

final class EditSavings extends SavingsEvent {
  final double newValue;

  EditSavings(this.newValue);
}

final class EditUserSavings extends SavingsEvent {
  final double expense;

  EditUserSavings(this.expense);
}
