import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const red = Color(0xffea4335);
  static const redSoft = Color(0xffFFEDEB);
  static const green = Color(0xff34a853);
  static const greenSoft = Color(0xffE5FFEC);
  static const yellow = Color(0xfff9ab00);
  static const yellowsoft = Color(0xffFFF5E0);
  static const white = Colors.white;
  static const black = Colors.black;
  
  static final orange = Colors.deepOrange.shade400;
}

MaterialColor convertToMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final r = color.red, g = color.green, b = color.blue;

  for (var i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
