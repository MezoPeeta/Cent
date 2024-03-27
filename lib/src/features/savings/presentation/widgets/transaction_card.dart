import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'icon_card.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard(
      {super.key,
      required this.name,
      required this.date,
      required this.icon,
      required this.amount,
      required this.type,
      required this.onTap});
  final String name, date, type;
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
            type == "expense"
                ? ExpenseWidget(amount: amount)
                : IncomeWidget(amount: amount)
          ],
        ),
      ),
    );
  }
}

class ExpenseWidget extends StatelessWidget {
  const ExpenseWidget({
    super.key,
    required this.amount,
  });

  final double amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.arrow_drop_down, color: Theme.of(context).colorScheme.error),
        Text(
          "\$$amount",
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.error),
        ),
      ],
    );
  }
}

class IncomeWidget extends StatelessWidget {
  const IncomeWidget({
    super.key,
    required this.amount,
  });

  final double amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.arrow_drop_up, color: Colors.green[700]),
        Text(
          "\$$amount",
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.green[700]),
        ),
      ],
    );
  }
}
