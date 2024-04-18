part of 'goals_bloc.dart';

@immutable
sealed class GoalsEvent {}

final class LoadGoalsEvent extends GoalsEvent {}

final class AddGoalEvent extends GoalsEvent {
  AddGoalEvent(this.goal);
  final Goal goal;
}

final class EditGoalEvent extends GoalsEvent {
  EditGoalEvent(this.goal);
  final Goal goal;
}

final class EditGoalTraAmountEvent extends GoalsEvent {
  EditGoalTraAmountEvent(this.goalID, this.transaction);
  final int goalID;
  final Transaction transaction;
}

final class DeleteGoalEvent extends GoalsEvent {
  DeleteGoalEvent(this.goalID);
  final int goalID;
}
