import 'package:cent/src/core/model/goal.dart';
import 'package:cent/src/core/model/transaction.dart';
import 'package:cent/src/core/utils/cache_helper.dart';
import 'package:cent/src/features/boarding/presentation/boarding.dart';
import 'package:cent/src/features/goals/presentation/screens/goal_detail.dart';
import 'package:cent/src/features/goals/presentation/screens/goals_edit.dart';
import 'package:cent/src/features/navigation/presentation/navigation.dart';
import 'package:cent/src/features/savings/presentation/screens/edit_transaction.dart';
import 'package:go_router/go_router.dart';

import '../../features/settings/presentation/widgets/biometrics_widget.dart';

final boardingDone = CacheHelper.getBool('boardingDone');

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>
          boardingDone ? InitBiometric(child: const Navigation()) : const BoardingScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const Navigation(),
    ),
    GoRoute(
      path: '/transaction/edit',
      builder: (context, state) =>
          EditTransactionScreen(transaction: state.extra! as Transaction),
    ),
    GoRoute(
      path: '/goal/edit',
      builder: (context, state) => EditGoalScreen(goal: state.extra! as Goal),
    ),
    GoRoute(
      path: '/goal/detail',
      builder: (context, state) => GoalDetailScreen(goal: state.extra! as Goal),
    ),
  ],
);
