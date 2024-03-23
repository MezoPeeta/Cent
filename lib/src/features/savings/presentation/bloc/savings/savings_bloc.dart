import 'package:cent/src/core/dao/savings_dao.dart';
import 'package:cent/src/core/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'savings_event.dart';
part 'savings_state.dart';

class SavingsBloc extends Bloc<SavingsEvent, User> {
  SavingsBloc()
      : super(User(
          id: 0,
          name: "",
          balance: 0.0,
        )) {
    on<LoadSavings>((event, emit) async {
      User user = await SavingsDao().getUser();
      await SavingsDao().update(user);

      emit(user);
    });
    on<EditSavings>((event, emit) async {
      User user = await SavingsDao().getUser();
      user = user.copyWith(balance: event.newValue, id: 1);
      await SavingsDao().update(user);
      emit(user);
    });
    on<EditUserSavings>((event, emit) async {
      User user = await SavingsDao().getUser();
      user = user.copyWith(balance: user.balance - event.expense, id: 1);
      await SavingsDao().update(user);

      emit(user);
    });
  }
}
