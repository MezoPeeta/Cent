import 'package:flutter/material.dart';

Color changeColorLightness(Color color, double value) =>
    HSLColor.fromColor(color).withLightness(value).toColor();
