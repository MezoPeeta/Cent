import 'package:cent/src/core/model/expense.dart';
import 'package:cent/src/features/savings/presentation/bloc/expense/expense_bloc.dart';
import 'package:cent/src/features/savings/presentation/bloc/savings/savings_bloc.dart';
import 'package:cent/src/features/savings/presentation/cubit/color_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/widgets/button.dart';
import '../goal_theme.dart';

class AddExpenseBottomSheet extends StatelessWidget {
  AddExpenseBottomSheet({
    super.key,
  });

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a name";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.sports_score_outlined),
                    label: Text("Expense Name")),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _amountController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter an anmount";
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.attach_money_outlined),
                    label: Text("Amount")),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Choose an icon",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              Wrap(
                children: GoalTheme()
                    .icons
                    .map((icon) => BlocBuilder<IconCubit, int>(
                          builder: (context, state) {
                            bool isIconClicked = state == icon.codePoint;
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: InkWell(
                                    onTap: () {
                                      context
                                          .read<IconCubit>()
                                          .changeIcon(icon.codePoint);
                                    },
                                    borderRadius: BorderRadius.circular(16),
                                    radius: 5,
                                    child: Card(
                                      color: isIconClicked
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : null,
                                      child: Icon(
                                        icon,
                                        color: isIconClicked
                                            ? Theme.of(context)
                                                .colorScheme
                                                .onPrimary
                                            : null,
                                      ),
                                    ),
                                  ),
                                ));
                          },
                        ))
                    .toList(),
              ),
              const Spacer(),
              CustomElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      int expenseIcon = context.read<IconCubit>().state;
                      Expense expense = Expense(
                          name: _nameController.text,
                          amount: double.parse(_amountController.text),
                          icon: expenseIcon);
                      context.read<ExpenseBloc>().add(AddExpenseEvent(expense));

                      context
                          .read<SavingsBloc>()
                          .add(EditUserSavings(expense.amount));

                      context.pop();
                    }
                  },
                  text: "Add Expense",
                  width: double.infinity,
                  icon: Icons.archive_outlined)
            ],
          ),
        ),
      ),
    );
  }
}
