import 'package:cent/src/features/navigation/cubit/navigation_cubit.dart';
import 'package:cent/src/features/loans/loans.dart';
import 'package:cent/src/features/savings/presentation/screens/savings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [const SavingsScreen(), const LoanScreen()];
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: children[state],
          bottomNavigationBar: NavigationBar(
              height: 70,
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              selectedIndex: state,
              onDestinationSelected: (value) =>
                  context.read<NavigationCubit>().changePage(value),
              destinations: [
                NavigationDestination(
                    icon: Icon(state == 0 ? Icons.home : Icons.home_outlined),
                    label: "Home"),
                NavigationDestination(
                    icon: Icon(state == 1
                        ? Icons.monetization_on
                        : Icons.monetization_on_outlined),
                    label: "Loans")
              ]),
        );
      },
    );
  }
}
