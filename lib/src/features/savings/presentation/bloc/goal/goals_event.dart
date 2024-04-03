part of 'goals_bloc.dart';


@immutable
sealed class GoalsEvent {}

final class LoadGoalsEvent extends GoalsEvent {}

final class AddGoalEvent extends GoalsEvent {

  AddGoalEvent(this.goal);
  final Goal goal;
}
