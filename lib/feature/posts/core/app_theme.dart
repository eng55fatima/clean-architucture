// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

final primaryColor = Color(0xff082659);

final secondryColor = Color(0xff51eec2);

final appTheme = ThemeData(
    appBarTheme: AppBarTheme(backgroundColor: primaryColor, centerTitle: true),
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(primary: primaryColor),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: secondryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: primaryColor),
      iconColor: secondryColor,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: secondryColor),
          borderRadius: BorderRadius.circular(8)),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: secondryColor),
          borderRadius: BorderRadius.circular(8)),
    ));
