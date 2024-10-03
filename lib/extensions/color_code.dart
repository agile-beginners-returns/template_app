import 'package:flutter/material.dart';

const String mainBackGroundColor = "#0E0D66";
const String subBackGroundColor = "#459BE6";
const String accentBackGroundColor = "#EA3368";
const String foregroundColor = "#FFFFFF";

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    // 引数を全部大文字に変換して、#を取り除く
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
