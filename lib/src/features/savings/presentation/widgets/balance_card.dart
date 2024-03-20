import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
    required this.widget,
  });

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 106,
      child: Card(
        child: Padding(padding: const EdgeInsets.all(10.0), child: widget),
      ),
    );
  }
}
