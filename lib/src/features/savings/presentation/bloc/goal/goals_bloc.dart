import 'package:cent/src/core/dao/goals_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/model/goal.dart';
part 'goals_event.dart';

class GoalsBloc extends Bloc<GoalsEvent, List<Goal>> {
  GoalsBloc() : super(const []) {
    on<LoadGoalsEvent>((event, emit) async {
      final List<Goal> goals = await GoalDao().getGoals();
      emit(goals);
    });
    on<AddGoalEvent>((event, emit) async {
      await GoalDao().insert(Goal(
        name: event.goal.name,
        amount: event.goal.amount,
        color: event.goal.color ?? 4294967295,
        icon: event.goal.icon,
      ));
      final List<Goal> goals = await GoalDao().getGoals();
      emit(goals);
    });
  }
}
