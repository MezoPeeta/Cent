import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/app.dart';
import 'src/core/utils/cache_helper.dart';
import 'src/features/navigation/cubit/navigation_cubit.dart';
import 'src/features/savings/presentation/bloc/goal/goals_bloc.dart';
import 'src/features/savings/presentation/bloc/savings/savings_bloc.dart';
import 'src/features/savings/presentation/bloc/transaction/transaction_bloc.dart';
import 'src/features/savings/presentation/cubit/color_cubit.dart';
import 'src/features/savings/presentation/cubit/icon_cubit.dart';
import 'src/features/savings/presentation/cubit/transaction_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => SavingsBloc()..add(LoadSavings())),
    BlocProvider(create: (_) => NavigationCubit()),
    BlocProvider(create: (_) => GoalsBloc()..add(LoadGoalsEvent())),
    BlocProvider(create: (_) => TransactionBloc()..add(LoadTransactionEvent())),
    BlocProvider(create: (_) => ColorCubit()),
    BlocProvider(create: (_) => IconCubit()),
    BlocProvider(create: (_) => TransactionCubit()),
  ], child: const MyApp()));
}
