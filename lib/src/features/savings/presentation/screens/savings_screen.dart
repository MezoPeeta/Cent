import 'package:cent/src/core/model/transaction.dart';
import 'package:cent/src/features/savings/presentation/bloc/transaction/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../widgets/icon_card.dart';
import '../widgets/transaction_bottom_sheet.dart';
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
                                      extra: Transaction(
                                          id: transactions[index].id,
                                          name: transactions[index].name,
                                          amount: transactions[index].amount,
                                          icon: transactions[index].icon)),
                                  name: transactions[index].name,
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

class TransactionCard extends StatelessWidget {
  const TransactionCard(
      {super.key,
      required this.name,
      required this.date,
      required this.icon,
      required this.amount,
      required this.onTap});
  final String name, date;
  final int icon;
  final double amount;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            IconCard(icon: IconData(icon, fontFamily: "MaterialIcons")),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 16.5, fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat.yMMMd().format(DateTime.parse(date)),
                  style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.5)),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Icon(Icons.arrow_drop_down,
                    color: Theme.of(context).colorScheme.error),
                Text(
                  "\$$amount",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.error),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
