import 'package:cent/src/features/savings/presentation/widgets/balance_card.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.name,
    required this.category,
    required this.amount,
  });

  final String name, category;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return BalanceCard(
        widget: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 30,
          child: Icon(Icons.checkroom_outlined),
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name),
            Text(
              category,
              style: TextStyle(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
            ),
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text("- $amount"),
        )
      ],
    ));
  }
}
