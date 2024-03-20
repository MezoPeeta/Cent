import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/widgets/button.dart';
import '../../../../core/model/goal.dart';
import '../bloc/goal/goals_bloc.dart';
import '../cubit/color_cubit.dart';
import '../goal_theme.dart';

class AddGoalBottomSheet extends StatelessWidget {
  AddGoalBottomSheet({
    super.key,
    required TextEditingController nameController,
    required TextEditingController amountController,
  })  : _nameController = nameController,
        _amountController = amountController;

  final TextEditingController _nameController;
  final TextEditingController _amountController;
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
                    label: Text("Goal Name")),
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
                "Choose a color",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              Wrap(
                children: GoalTheme()
                    .colors
                    .map((color) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: InkWell(
                            onTap: () {
                              context
                                  .read<ColorCubit>()
                                  .changeColor(color.value);
                            },
                            borderRadius: BorderRadius.circular(16),
                            radius: 5,
                            child: BlocBuilder<ColorCubit, int>(
                              builder: (context, state) {
                                bool isColorClicked = state == color.value;
                                return Container(
                                  decoration: BoxDecoration(
                                    border: isColorClicked
                                        ? Border.all(color: color)
                                        : null,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Card(
                                    color: color,
                                  ),
                                );
                              },
                            ),
                          ),
                        )))
                    .toList(),
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
                      int goalColor = context.read<ColorCubit>().state;
                      int goalIcon = context.read<IconCubit>().state;
                      Goal goal = Goal(
                          name: _nameController.text,
                          amount: double.parse(_amountController.text),
                          color: goalColor,
                          icon: goalIcon);
                      context.read<GoalsBloc>().add(AddGoalEvent(goal));
                    }
                    context.pop();
                  },
                  text: "Add Goal",
                  width: double.infinity,
                  icon: Icons.archive_outlined)
            ],
          ),
        ),
      ),
    );
  }
}
