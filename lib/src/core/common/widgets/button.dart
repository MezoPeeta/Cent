import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.width = 250,
      required this.icon});

  final void Function() onPressed;
  final String text;
  final IconData icon;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(text),
      ),
    );
  }
}
