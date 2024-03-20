import 'package:cent/src/core/model/goal.dart';
import 'package:flutter/material.dart';

@immutable
sealed class GoalsState {}

// ignore: must_be_immutable
final class GoalsInitial extends GoalsState {
  List<Goal> goal;

  GoalsInitial(this.goal);
}
