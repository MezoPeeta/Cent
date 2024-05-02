import 'package:cent/src/core/common/widgets/delete_dialog.dart';
import 'package:cent/src/core/common/widgets/icon_custom_shape.dart';
import 'package:cent/src/core/model/goal.dart';
import 'package:cent/src/features/goals/presentation/bloc/goal/goals_bloc.dart';
import 'package:cent/src/features/savings/presentation/bloc/transaction/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditGoalScreen extends StatelessWidget {
  EditGoalScreen({required this.goal, super.key});
  final Goal goal;
  final _formKey = GlobalKey<FormState>();
  late final nameController = TextEditingController(text: goal.name);
  late final amountController =
      TextEditingController(text: goal.amount.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: const Text('Edit Goal'),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog<Widget>(
                    context: context,
                    builder: (context) => DeleteDialog(
                      title: 'Delete Goal',
                      content: 'Delete ${goal.name}',
                      deleteOnPressed: () {
                        context
                            .read<GoalsBloc>()
                            .add(DeleteGoalEvent(goal.id!));
                        context
                            .read<TransactionBloc>()
                            .add(DeleteAllTransactionGoalsEvent(goal.id!));
                        context.go('/home');
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
          SliverToBoxAdapter(
            // ignore: prefer_const_constructors
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    // ignore: prefer_const_constructors
                    IconCustomShape(
                      color: Color(goal.color),
                      icon: IconData(
                        goal.icon,
                        fontFamily: 'MaterialIcons',
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$${goal.amount}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            goal.name,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(label: Text('Name')),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: amountController,
                      decoration: const InputDecoration(label: Text('Amount')),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final currentAmount =
                              double.parse(amountController.text);

                          final edittedGoal = Goal(
                            amount: currentAmount,
                            name: nameController.text,
                            icon: goal.icon,
                            color: goal.color,
                            id: goal.id,
                            traAmount: goal.traAmount,
                          );
                          if (_formKey.currentState!.validate()) {
                            context
                                .read<GoalsBloc>()
                                .add(EditGoalEvent(edittedGoal));
                            context.pop();
                          }
                        },
                        icon: const Icon(Icons.save_alt),
                        label: const Text('Save Changes'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
