part of 'transaction_bloc.dart';

@immutable
sealed class TransactionEvent {}

final class LoadTransactionEvent extends TransactionEvent {}

final class AddTransactionEvent extends TransactionEvent {
  final Transaction transaction;

  AddTransactionEvent(this.transaction);
}

final class DeleteTransactionEvent extends TransactionEvent {
  final int id;

  DeleteTransactionEvent(this.id);
}
