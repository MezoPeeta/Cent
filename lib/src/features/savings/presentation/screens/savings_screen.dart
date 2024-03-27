import 'package:cent/src/core/model/transaction.dart';
import 'package:cent/src/features/savings/presentation/bloc/transaction/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../widgets/icon_card.dart';
import '../widgets/transaction_bottom_sheet.dart';
import '../widgets/transaction_card.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 15),
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
                        "Good Morning,",
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
              const BalanceCard(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Transaction",
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              BlocBuilder<TransactionBloc, List<Transaction>>(
                builder: (context, transactions) {
                  return Column(
                      children: List.generate(
                          transactions.length,
                          (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: TransactionCard(
                                  onTap: () => context.push('/transaction/edit',
                                      extra: transactions[index]),
                                  name: transactions[index].name,
                                  type: transactions[index].type,
                                  date: transactions[index].createdAt,
                                  amount: transactions[index].amount,
                                  icon: transactions[index].icon,
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
              builder: (context) => AddTransactionBottomSheet());
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
