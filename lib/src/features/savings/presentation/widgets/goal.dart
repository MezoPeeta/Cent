import 'package:cent/src/core/common/widgets/button.dart';
import 'package:cent/src/core/model/goal.dart';
import 'package:cent/src/features/savings/presentation/cubit/color_cubit.dart';
import 'package:cent/src/features/savings/presentation/goal_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/goal/goals_bloc.dart';

class GoalCard extends StatelessWidget {
  const GoalCard({
    super.key,
    required this.category,
    required this.name,
    required this.icon,
  });
  final String category, name;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 121,
      width: 172,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 17,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(category)
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                name,
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(r"$50"),
                  Text(r"$50"),
                ],
              ),
              const LinearProgressIndicator(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                value: 0.2,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AddGoal extends StatelessWidget {
  AddGoal({super.key});

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 121,
      width: 50,
      child: Card(
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                showDragHandle: true,
                useSafeArea: true,
                builder: (context) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.sports_score_outlined),
                                  label: Text("Goal Name")),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _amountController,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
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
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          radius: 5,
                                          child: BlocBuilder<ColorCubit, int>(
                                            builder: (context, state) {
                                              bool isColorClicked =
                                                  state == color.value;
                                              return Container(
                                                decoration: BoxDecoration(
                                                  border: isColorClicked
                                                      ? Border.all(color: color)
                                                      : null,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                          bool isIconClicked =
                                              state == icon.codePoint;
                                          return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: 40,
                                                height: 40,
                                                child: InkWell(
                                                  onTap: () {
                                                    context
                                                        .read<IconCubit>()
                                                        .changeIcon(
                                                            icon.codePoint);
                                                  },
                                                  borderRadius:
                                                      BorderRadius.circular(16),
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
                                  int goalColor =
                                      context.read<ColorCubit>().state;
                                  int goalIcon =
                                      context.read<IconCubit>().state;
                                  Goal goal = Goal(
                                      name: _nameController.text,
                                      amount:
                                          double.parse(_amountController.text),
                                      color: goalColor,
                                      icon: goalIcon);
                                  context
                                      .read<GoalsBloc>()
                                      .add(AddGoalEvent(goal));
                                },
                                text: "Add Goal",
                                width: double.infinity,
                                icon: Icons.archive_outlined)
                          ],
                        ),
                      ),
                    ));
          },
          borderRadius: BorderRadius.circular(10),
          child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Icon(Icons.add_outlined),
              )),
        ),
      ),
    );
  }
}
