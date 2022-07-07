import 'package:flutter/material.dart';

class HexColor extends Color {
  static int convertHexToColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = '0xFF$hexColor';
    }
    return int.parse(hexColor);
  }

  HexColor(final String hexColor) : super(convertHexToColor(hexColor));
}
