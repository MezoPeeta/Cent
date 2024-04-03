import 'package:flutter/material.dart';

class IconCard extends StatelessWidget {
  const IconCard({
    required this.icon, super.key,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Icon(
        icon,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }
}
