import 'package:cent/src/core/common/constants.dart';
import 'package:cent/src/core/common/widgets/icon_custom_shape.dart';
import 'package:cent/src/core/model/goal.dart';
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
    return SizedBox(
      height: 150,
      child: FilledButton(
        onLongPress: () => context.push('/goal/edit', extra: goal),
        onPressed: () => context.push('/goal/detail', extra: goal),
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(
            changeColorLightness(Color(goal.color), 0.9),
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
                  Text(
                    goal.name,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: changeColorLightness(Color(goal.color), 0.3),
                    ),
                  ),
                  IconCustomShape(
                    color: Color(goal.color),
                    icon: IconData(goal.icon, fontFamily: 'MaterialIcons'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${goal.traAmount}',
                    style: TextStyle(
                      color: changeColorLightness(Color(goal.color), 0.3),
                    ),
                  ),
                  Text(
                    '\$${goal.amount}',
                    style: TextStyle(
                      color: changeColorLightness(Color(goal.color), 0.3),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              LinearProgressIndicator(
                value: goal.traAmount / goal.amount,
                borderRadius: BorderRadius.circular(8),
                backgroundColor: Color(goal.color).withOpacity(0.2),
                minHeight: 10,
                valueColor: AlwaysStoppedAnimation<Color>(
                  changeColorLightness(Color(goal.color), 0.3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
