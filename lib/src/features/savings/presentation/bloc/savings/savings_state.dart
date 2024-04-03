part of 'savings_bloc.dart';

@immutable
sealed class SavingsState {}

// ignore: must_be_immutable
final class SavingsInitial extends SavingsState {

  SavingsInitial(this.user);
  User user = User(
    id: 0,
    name: '',
    balance: 0,
  );
}
