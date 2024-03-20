import 'package:cent/src/app.dart';
import 'package:cent/src/features/navigation/cubit/navigation_cubit.dart';
import 'package:cent/src/features/savings/presentation/bloc/goal/goals_bloc.dart';
import 'package:cent/src/features/savings/presentation/bloc/savings/savings_bloc.dart';
import 'package:cent/src/features/savings/presentation/cubit/color_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => SavingsBloc()..add(LoadSavings())),
    BlocProvider(create: (_) => NavigationCubit()),
    BlocProvider(create: (_) => GoalsBloc()..add(LoadGoalsEvent())),
    BlocProvider(create: (_) => ColorCubit()),
    BlocProvider(create: (_) => IconCubit()),
  ], child: const MyApp()));
}
