import 'package:cent/src/features/navigation/presentation/navigation.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Navigation(),
    ),
  ],
);
