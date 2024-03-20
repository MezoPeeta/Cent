part of 'goals_bloc.dart';


@immutable
sealed class GoalsEvent {}

final class LoadGoalsEvent extends GoalsEvent {}

final class AddGoalEvent extends GoalsEvent {
  final Goal goal;

  AddGoalEvent(this.goal);
}
