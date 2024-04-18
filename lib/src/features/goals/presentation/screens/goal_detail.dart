import 'package:cent/src/core/common/widgets/header_text.dart';
import 'package:cent/src/core/model/goal.dart';
import 'package:cent/src/features/goals/presentation/bloc/goal/goals_bloc.dart';
import 'package:cent/src/features/savings/presentation/bloc/transaction/transaction_bloc.dart';
import 'package:cent/src/features/savings/presentation/widgets/icon_card.dart';
import 'package:cent/src/features/savings/presentation/widgets/transaction_bottom_sheet.dart';
import 'package:cent/src/features/savings/presentation/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GoalDetailScreen extends StatelessWidget {
  const GoalDetailScreen({required this.goal, super.key});
  final Goal goal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: const Text('Savings Jar'),
            actions: [
              IconButton(
                onPressed: () => context.push('/goal/edit', extra: goal),
                icon: const Icon(Icons.edit_outlined),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: SafeArea(
              child: Column(
                children: [
                  Builder(
                    builder: (context) {
                      final goalTransactionAmount = context
                          .watch<GoalsBloc>()
                          .state
                          .where((element) => element.id == goal.id)
                          .first
                          .traAmount;
                      final percentage = goalTransactionAmount / goal.amount;
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            height: 200,
                            child: CircularProgressIndicator(
                              value: percentage,
                              strokeCap: StrokeCap.round,
                              backgroundColor:
                                  Color(goal.color).withOpacity(0.1),
                              strokeWidth: 7,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(goal.color),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              IconCard(
                                backgroundColor: Color(goal.color),
                                icon: IconData(
                                  goal.icon,
                                  fontFamily: 'MaterialIcons',
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                '${(percentage * 100).roundToDouble()}%',
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: HeaderText(
                header: 'Transaction',
              ),
            ),
          ),
          BlocConsumer<TransactionBloc, TransactionState>(
            listener: (context, state) {
              if (state is TransactionError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              if (state is TransactionInitial) {
                final goalTransactions = state.transactions
                    .where((element) => element.goalID == goal.id)
                    .toList();
                return SliverList.builder(
                  itemCount: goalTransactions.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: TransactionCard(
                        name: goalTransactions[index].name,
                        date: DateTime.now().toString(),
                        icon: goalTransactions[index].icon,
                        amount: goalTransactions[index].amount,
                        type: goalTransactions[index].type,
                        onTap: () {},
                      ),
                    );
                  },
                );
              }
              return Container();
            },
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 70,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<Widget>(
            context: context,
            showDragHandle: true,
            useSafeArea: true,
            isScrollControlled: true,
            builder: (context) => AddTransactionBottomSheet(
              goalID: goal.id!,
            ),
          );
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
