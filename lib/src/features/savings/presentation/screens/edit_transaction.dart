import 'package:cent/src/core/model/transaction.dart';
import 'package:cent/src/features/savings/presentation/widgets/icon_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/transaction/transaction_bloc.dart';

class EditTransactionScreen extends StatelessWidget {
  const EditTransactionScreen({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: const Text("Edit Transaction"),
            actions: [
              IconButton(
                  onPressed: () {
                    context
                        .read<TransactionBloc>()
                        .add(DeleteTransactionEvent(transaction.id!));
                    context.pop();
                  },
                  icon: const Icon(Icons.delete_outline_outlined))
            ],
          ),
          // ignore: prefer_const_constructors
          SliverToBoxAdapter(
              // ignore: prefer_const_constructors
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              // ignore: prefer_const_constructors
              IconCard(
                  icon:
                      IconData(transaction.icon, fontFamily: "MaterialIcons")),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\$${transaction.amount}",
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                      width: 100,
                      child: Text(
                        transaction.name,
                      ))
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }
}
