import 'package:cent/src/features/goals/presentation/screens/goals_screen.dart';
import 'package:cent/src/features/navigation/cubit/navigation_cubit.dart';
import 'package:cent/src/features/savings/presentation/screens/savings_screen.dart';
import 'package:cent/src/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});
  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      const SavingsScreen(),
      const GoalsScreen(),
      const SettingsScreen(),
    ];
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: children[state],
          bottomNavigationBar: NavigationBar(
            height: 70,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            selectedIndex: state,
            onDestinationSelected: (value) =>
                context.read<NavigationCubit>().changePage(value),
            destinations: [
              NavigationDestination(
                icon: Icon(state == 0 ? Icons.home : Icons.home_outlined),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(
                  state == 1
                      ? Icons.monetization_on
                      : Icons.monetization_on_outlined,
                ),
                label: 'Goals',
              ),
              NavigationDestination(
                icon: Icon(
                  state == 2 ? Icons.settings : Icons.settings_outlined,
                ),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
