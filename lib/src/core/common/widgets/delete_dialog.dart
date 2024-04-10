import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    required this.title,
    required this.content,
    super.key,
    this.deleteOnPressed,
  });

  final String title;
  final String content;
  final void Function()? deleteOnPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: deleteOnPressed,
          child: Text(
            'Delete',
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      ],
    );
  }
}
