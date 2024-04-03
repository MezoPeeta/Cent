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
              borderRadius: BorderRadius.circular(25),),
          child: InkWell(
            onTap: () {
              showModalBottomSheet<Widget>(
                  context: context,
                  builder: (context) => EditBalance(
                        initialValue: '0.0',
                      ),);
            },
            borderRadius: BorderRadius.circular(25),
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
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${state.balance}',
                            style: const TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold,),
                          ),
                          // FilledButton.icon(
                          //     onPressed: () {
                          //       showModalBottomSheet(
                          //           context: context,
                          //           builder: (context) => EditBalance(
                          //                 initialValue: "${state.balance}",
                          //               ));
                          //     },
                          //     icon: const Icon(Icons.edit_outlined),
                          //     label: const Text("Edit"))
                        ],
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
