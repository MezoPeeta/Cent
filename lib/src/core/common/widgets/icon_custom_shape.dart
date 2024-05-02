import 'package:flutter/material.dart';

class IconCustomShape extends StatelessWidget {
  const IconCustomShape({
    required this.color,
    required this.icon,
    super.key,
  });

  final Color color;
  final IconData icon;
  Color changeColorLightness(Color color, double value) =>
      HSLColor.fromColor(color).withLightness(value).toColor();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: 90,
      child: Card(
        color: color,
        shape: const StarBorder(
          rotation: 45,
          points: 4,
          pointRounding: 0.85,
          innerRadiusRatio: 0.35,
        ),
        child: Icon(
          icon,
          color: changeColorLightness(color, 0.8),
        ),
      ),
    );
  }
}
