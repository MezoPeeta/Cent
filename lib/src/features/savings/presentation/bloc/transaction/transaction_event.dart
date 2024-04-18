part of 'transaction_bloc.dart';

@immutable
sealed class TransactionEvent {}

final class LoadTransactionEvent extends TransactionEvent {}

final class AddTransactionEvent extends TransactionEvent {
  AddTransactionEvent(this.transaction);
  final Transaction transaction;
}

final class EditTransaction extends TransactionEvent {
  EditTransaction(this.transaction);
  final Transaction transaction;
}

final class DeleteTransactionEvent extends TransactionEvent {
  DeleteTransactionEvent(this.id);
  final int id;
}

final class DeleteAllTransactionGoalsEvent extends TransactionEvent {
  DeleteAllTransactionGoalsEvent(this.goalID);
  final int goalID;
}
