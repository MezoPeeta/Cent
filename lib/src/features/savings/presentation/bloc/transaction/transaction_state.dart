part of 'transaction_bloc.dart';

@immutable
sealed class TransactionState {}

final class TransactionInitial extends TransactionState {
  TransactionInitial({this.transactions = const []});
  final List<Transaction> transactions;
}
