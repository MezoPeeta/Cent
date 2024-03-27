import 'package:cent/src/core/common/enums/transaction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionCubit extends Cubit<TransactionType> {
  TransactionCubit() : super(TransactionType.expense);

  void changeType(TransactionType newValue) {
    emit(newValue);
  }
}
