import 'package:cent/src/core/model/transaction.dart';
import 'package:cent/src/core/utils/cache_helper.dart';
import 'package:cent/src/features/boarding/presentation/boarding.dart';
import 'package:cent/src/features/navigation/presentation/navigation.dart';
import 'package:cent/src/features/savings/presentation/screens/edit_transaction.dart';
import 'package:go_router/go_router.dart';

final boardingDone = CacheHelper.getBool('boardingDone');

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>
         boardingDone ? const Navigation() : const BoardingScreen(),
      
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
  ],
);
