import 'package:cent/src/core/dao/goals_dao.dart';
import 'package:cent/src/core/model/goal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'goals_event.dart';

class GoalsBloc extends Bloc<GoalsEvent, List<Goal>> {
  GoalsBloc() : super(const []) {
    on<LoadGoalsEvent>((event, emit) async {
      final goals = await GoalDao().getGoals();
      emit(goals);
    });
    on<AddGoalEvent>((event, emit) async {
      await GoalDao().insert(
        Goal(
          name: event.goal.name,
          amount: event.goal.amount,
          color: event.goal.color,
          icon: event.goal.icon,
        ),
      );
      final goals = await GoalDao().getGoals();
      emit(goals);
    });
    on<DeleteGoalEvent>((event, emit) async {
      await GoalDao().delete(event.goalID);
      final goals = await GoalDao().getGoals();
      emit(goals);
    });
    on<EditGoalEvent>((event, emit) async {
      await GoalDao().update(event.goal);
      final goals = await GoalDao().getGoals();
      emit(goals);
    });
  }
}
