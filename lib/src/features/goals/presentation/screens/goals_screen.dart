import 'package:cent/src/core/model/goal.dart';
import 'package:cent/src/features/goals/presentation/bloc/goal/goals_bloc.dart';
import 'package:cent/src/features/goals/presentation/screens/widgets/goal_bottom_sheet.dart';
import 'package:cent/src/features/goals/presentation/screens/widgets/goal_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 20,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                BlocBuilder<GoalsBloc, List<Goal>>(
                  builder: (context, goals) {
                    return Column(
                      children: List.generate(
                        goals.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: GoalContainer(
                            goal: goals[index],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    child: const Icon(Icons.add),
                    onPressed: () {
                      showModalBottomSheet<Widget>(
                        context: context,
                        isScrollControlled: true,
                        useSafeArea: true,
                        showDragHandle: true,
                        builder: (context) => AddGoalBottomSheet(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
