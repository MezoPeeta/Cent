import 'package:cent/src/core/model/expense.dart';
import 'package:cent/src/core/model/user.dart';
import 'package:cent/src/features/savings/presentation/bloc/expense/expense_bloc.dart';
import 'package:cent/src/features/savings/presentation/bloc/savings/savings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/model/goal.dart';
import '../bloc/goal/goals_bloc.dart';
import '../widgets/expense_bottom_sheet.dart';
import '../widgets/widgets.dart';

class SavingsScreen extends StatelessWidget {
  const SavingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good Morning",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        "Mazen Omar",
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  CircleAvatar()
                ],
              ),
              BalanceCard(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Savings Balance"),
                    BlocBuilder<SavingsBloc, User>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${state.balance}',
                              style: const TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                            FilledButton.icon(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) => EditBalance(
                                            initialValue: "${state.balance}",
                                          ));
                                },
                                icon: const Icon(Icons.edit_outlined),
                                label: const Text("Edit"))
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
              const Text("My goals"),
              BlocBuilder<GoalsBloc, List<Goal>>(
                builder: (context, goals) {
                  double userBalance =
                      context.watch<SavingsBloc>().state.balance;

                  return SizedBox(
                    height: 121,
                    child: Row(
                      children: [
                        const AddGoal(),
                        Expanded(
                          child: ListView.builder(
                              itemCount: goals.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GoalCard(
                                  userBalance: userBalance,
                                  color: Color(goals[index].color),
                                  amount: goals[index].amount,
                                  name: goals[index].name,
                                  icon: IconData(goals[index].icon,
                                      fontFamily: "MaterialIcons"),
                                );
                              }),
                        )
                      ],
                    ),
                  );
                },
              ),
              const Text("Expenses"),
              BlocBuilder<ExpenseBloc, List<Expense>>(
                builder: (context, expenses) {
                  return Column(
                      children: List.generate(
                          expenses.length,
                          (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Transaction(
                                  name: expenses[index].name,
                                  date: expenses[index].createdAt,
                                  amount: expenses[index].amount,
                                  icon: expenses[index].icon,
                                ),
                              )));
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              showDragHandle: true,
              useSafeArea: true,
              isScrollControlled: true,
              context: context,
              builder: (context) => AddExpenseBottomSheet());
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}

class Transaction extends StatelessWidget {
  const Transaction({
    super.key,
    required this.name,
    required this.date,
    required this.icon,
    required this.amount,
  });
  final String name, date;
  final int icon;
  final double amount;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          child: Icon(IconData(icon, fontFamily: 'MaterialIcons')),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 16.5),
            ),
            Text(
              date,
              style: TextStyle(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
            ),
          ],
        ),
        const Spacer(),
        Text(
          "\$$amount",
        )
      ],
    );
  }
}
