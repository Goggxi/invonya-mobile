import 'package:flutter/material.dart';

import '../../core/core.dart';

class AppThemes {
  AppThemes._();

  static final ThemeData lightTheme = ThemeData(
    textTheme: _textTheme,
    primaryTextTheme: _textTheme,
    // colorScheme: const ColorScheme(
    //     brightness: Brightness.light,
    //     primary: AppColors.red,
    //     onPrimary: AppColors.white,
    //     secondary: AppColors.red,
    //     onSecondary: AppColors.black,
    //     error: AppColors.red,
    //     onError: AppColors.red,
    //     background: AppColors.white,
    //     onBackground: AppColors.white,
    //     surface: AppColors.red,
    //     onSurface: AppColors.black),
    primarySwatch: convertToMaterialColor(AppColors.orange),
    appBarTheme: AppBarTheme(
      elevation: 0.5,
      backgroundColor: Colors.grey.shade50,
      foregroundColor: Colors.black87,
      shadowColor: Colors.transparent,
      titleTextStyle: _textTheme.headline6?.copyWith(
        color: Colors.black54,
        fontWeight: FontWeight.bold,
        fontFamily: "Lobster",
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 0.0,
      focusElevation: 0.0,
      highlightElevation: 0.0,
      foregroundColor: AppColors.white,
    ),
    scaffoldBackgroundColor: AppColors.white,
  );

  static const _textTheme = TextTheme(
    headline6: TextStyle(
        fontFamily: "Inter",
        fontSize: 20.0,
        letterSpacing: 0.15,
        color: Colors.black,
        fontWeight: FontWeight.w900,
        fontStyle: FontStyle.normal),
    button: TextStyle(
        fontFamily: "Inter",
        fontSize: 16.0,
        letterSpacing: 0.65,
        fontWeight: FontWeight.w800,
        fontStyle: FontStyle.normal),
    subtitle1: TextStyle(
        fontFamily: "Inter",
        fontSize: 16.0,
        letterSpacing: 0.0,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal),
    subtitle2: TextStyle(
        fontFamily: "Inter",
        fontSize: 14.0,
        letterSpacing: 0.1,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal),
    bodyText1: TextStyle(
        fontFamily: "Inter",
        fontSize: 16.0,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal),
    bodyText2: TextStyle(
        fontFamily: "Inter",
        fontSize: 14.0,
        letterSpacing: 0.25,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal),
    caption: TextStyle(
        fontFamily: "Inter",
        fontSize: 12.0,
        letterSpacing: 0.4,
        fontStyle: FontStyle.normal),
  );
}
