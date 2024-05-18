import 'package:cent/src/core/model/user.dart';
import 'package:cent/src/features/savings/presentation/bloc/savings/savings_bloc.dart';
import 'package:cent/src/features/savings/presentation/widgets/edit_balance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Material(
        child: Ink(
          width: double.infinity,
          height: 155,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () {
              showModalBottomSheet<Widget>(
                context: context,
                builder: (context) {
                  final userBalance = context.read<SavingsBloc>().state.balance;
                  return EditBalance(
                    initialValue: '$userBalance',
                  );
                },
              );
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Balance',
                    style: TextStyle(fontSize: 22, fontFamily: 'Firs Neue'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<SavingsBloc, User>(
                    builder: (context, state) {
                      return Text(
                        '\$${state.balance}',
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
