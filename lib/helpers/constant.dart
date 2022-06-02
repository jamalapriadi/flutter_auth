import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class Warna {
  static Color kuning = HexColor("#FBC833");
  static Color putih = HexColor("#FFFFFF");
  static Color hitam = HexColor("#000000");
  static Color hijau = HexColor("#72bf44");
  static Color biru = HexColor("#0082c6");
  static Color abu = HexColor("#404041");
  static Color abumuda = HexColor("#e5e5e5");
}
