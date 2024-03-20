import 'package:cent/src/core/model/user.dart';
import 'package:cent/src/features/savings/presentation/bloc/goal/goals_state.dart';
import 'package:cent/src/features/savings/presentation/bloc/savings/savings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/model/goal.dart';
import '../bloc/goal/goals_bloc.dart';
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
                  return SizedBox(
                    height: 121,
                    child: Row(
                      children: [
                        AddGoal(),
                        Expanded(
                          child: ListView.builder(
                              itemCount: goals.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GoalCard(
                                  category: "Category",
                                  name: goals[index].name,
                                  icon: IconData(goals[index].icon,
                                      fontFamily: "MaterialIcons"),
                                );
                              }),
                        )
                      ],
                    ),
                  );

                  return SizedBox(
                    height: 121,
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: goals.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GoalCard(
                            category: "Category",
                            name: goals[index].name,
                            icon: IconData(goals[index].icon),
                          );
                        }),
                  );
                },
              ),
              const Text("My transactions"),

              // SizedBox.expand(
              //   child: ListView.separated(
              //       itemCount: 5,
              //       separatorBuilder: (context, index) => const SizedBox(
              //             height: 18,
              //           ),
              //       itemBuilder: (context, index) {
              //         return const TransactionCard(
              //           name: "Buy IPhone",
              //           category: "Clothing",
              //           amount: 12.0,
              //         );
              //       }),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
