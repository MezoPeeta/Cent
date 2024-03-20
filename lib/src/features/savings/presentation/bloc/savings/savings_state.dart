part of 'savings_bloc.dart';

@immutable
sealed class SavingsState {}

// ignore: must_be_immutable
final class SavingsInitial extends SavingsState {
  User user = User(
    id: 0,
    name: "",
    balance: 0.0,
  );

  SavingsInitial(this.user);
}
