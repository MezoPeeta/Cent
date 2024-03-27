import 'package:cent/src/features/savings/presentation/widgets/goal_bottom_sheet.dart';
import 'package:flutter/material.dart';

class GoalCard extends StatelessWidget {
  const GoalCard(
      {super.key,
      required this.amount,
      required this.name,
      required this.userBalance,
      required this.icon,
      required this.color});
  final String name;
  final double amount, userBalance;
  final IconData icon;
  final Color color;

  Color changeColorLightness(Color color, double newLightnessValue) {
    if (color == Colors.black) {
      return Colors.white;
    }
    return HSLColor.fromColor(color).withLightness(newLightnessValue).toColor();
  }

  double calaculatePercentgge(amount, balance) {
    if (balance == 0.0) {
      return 0;
    }
    if (amount < balance) {
      return 100;
    }
    return ((balance / amount) * 100).roundToDouble();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 125,
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                      fontSize: 15.0, color: changeColorLightness(color, 0.2)),
                ),
              ),
              FittedBox(
                child: Text(
                  "\$$amount",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: changeColorLightness(color, 0.2)),
                ),
              ),
              Card(
                color: color.withOpacity(0.5),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "${calaculatePercentgge(amount, userBalance)}%",
                      style: TextStyle(color: changeColorLightness(color, 0.2)),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AddGoal extends StatelessWidget {
  const AddGoal({super.key});

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
                builder: (context) => AddGoalBottomSheet());
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
