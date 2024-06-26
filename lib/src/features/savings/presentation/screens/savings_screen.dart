import 'package:cent/src/core/common/widgets/header_text.dart';
import 'package:cent/src/core/model/user.dart';
import 'package:cent/src/features/savings/presentation/bloc/savings/savings_bloc.dart';
import 'package:cent/src/features/savings/presentation/bloc/transaction/transaction_bloc.dart';
import 'package:cent/src/features/savings/presentation/widgets/transaction_bottom_sheet.dart';
import 'package:cent/src/features/savings/presentation/widgets/transaction_card.dart';
import 'package:cent/src/features/savings/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SavingsScreen extends StatelessWidget {
  const SavingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hello,',
                    style: TextStyle(fontSize: 16),
                  ),
                  BlocBuilder<SavingsBloc, User>(
                    builder: (context, state) {
                      return Text(
                        state.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ],
              ),
              const BalanceCard(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeaderText(
                    header: 'Transaction',
                  ),
                ],
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
                    final transactions = state.transactions
                        .where((element) => element.goalID == 0)
                        .toList();
                    return Column(
                      children: List.generate(
                        transactions.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TransactionCard(
                            onTap: () => context.push(
                              '/transaction/edit',
                              extra: state.transactions[index],
                            ),
                            name: transactions[index].name,
                            type: transactions[index].type,
                            date: transactions[index].createdAt,
                            amount: transactions[index].amount,
                            icon: transactions[index].icon,
                          ),
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet<Widget>(
          showDragHandle: true,
          useSafeArea: true,
          isScrollControlled: true,
          context: context,
          builder: (context) => AddTransactionBottomSheet(),
        ),
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
