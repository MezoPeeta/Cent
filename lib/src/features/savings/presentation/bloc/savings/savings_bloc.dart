import 'package:cent/src/core/dao/savings_dao.dart';
import 'package:cent/src/core/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'savings_event.dart';
part 'savings_state.dart';

class SavingsBloc extends Bloc<SavingsEvent, User> {
  SavingsBloc()
      : super(
          User(
            id: 1,
            name: 'Guest',
            balance: 0,
          ),
        ) {
    on<LoadSavings>((event, emit) async {
      final user = await SavingsDao().getUser();
      emit(user);
    });
    on<EditSavings>((event, emit) async {
      var user = await SavingsDao().getUser();
      user = user.copyWith(balance: event.newValue, id: 1);
      await SavingsDao().update(user);
      emit(user);
    });
    on<EditUserSavings>((event, emit) async {
      var user = await SavingsDao().getUser();

      if (event.isExpense) {
        if (user.balance < event.transactionAmount) {
          user = user.copyWith(
            balance: 0,
            id: 1,
          );
        } else {
          user = user.copyWith(
            balance: user.balance - event.transactionAmount,
            id: 1,
          );
        }
      } else {
        user = user.copyWith(
          balance: user.balance + event.transactionAmount,
          id: 1,
        );
      }
      await SavingsDao().update(user);

      emit(user);
    });
    on<ChangeUserName>((event, emit) async {
      final user = state.copyWith(name: event.name, id: 1);
      await SavingsDao().update(user);
      emit(user);
    });
    on<AddUserBalance>((event, emit) async {
      final user = state.copyWith(balance: event.balance, id: 1);
      await SavingsDao().update(user);
      emit(user);
    });
  }
}
