import 'package:flutter/material.dart';

class IconCard extends StatelessWidget {
  const IconCard({
    required this.icon,
    this.backgroundColor,
    this.iconColor,
    super.key,
  });

  final IconData icon;
  final Color? backgroundColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color:
            backgroundColor ?? Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Icon(
        icon,
        color: iconColor ?? Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }
}
