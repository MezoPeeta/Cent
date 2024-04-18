import 'package:cent/src/core/model/goal.dart';
import 'package:cent/src/features/savings/presentation/widgets/icon_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoalContainer extends StatelessWidget {
  const GoalContainer({
    required this.goal,
    super.key,
  });

  final Goal goal;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 100,
      child: FilledButton(
        onPressed: () => context.push('/goal/detail', extra: goal),
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(
            colorScheme.primaryContainer,
          ),
          shape: MaterialStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        goal.name,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                      Text(
                        '\$${goal.traAmount}/${goal.amount}',
                        style: TextStyle(
                          color: colorScheme.onPrimaryContainer,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  IconCard(
                    icon: IconData(goal.icon, fontFamily: 'MaterialIcons'),
                    backgroundColor: Color(goal.color),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
