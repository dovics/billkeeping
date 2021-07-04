import 'package:flutter/material.dart';

final ThemeData themeLight = ThemeData(
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
  ),
  highlightColor: Color(0xFF527ff9),
  splashColor: Color.fromRGBO(0, 0, 0, 0),
  primaryColor: Color(0xff00BCD5),
  tabBarTheme: TabBarTheme(
    labelColor: Colors.white,
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.black,
          width: 2,
        ),
      ),
    ),
  ),
);
