import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({
    required this.header,
    super.key,
  });
  final String header;

  @override
  Widget build(BuildContext context) {
    return Text(
      header,
      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
    );
  }
}
