import 'package:flutter/material.dart';
import 'package:medicine_app/utilities/constants/color_constant.dart';

/// Custom Theme constants for light and dark mode.
class CTheme {
  /// Light Theme mode.
  static ThemeData lightTheme = ThemeData(
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: CColors.blue));

  /// Dark Theme mode.
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[850],
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: Colors.blue),
    drawerTheme: DrawerThemeData(backgroundColor: Colors.grey[850]),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.grey[850]),
    textTheme: const TextTheme(
        labelMedium: TextStyle(color: Colors.white70),
        labelLarge: TextStyle(color: Colors.white70),
        bodySmall: TextStyle(color: Colors.white30)),
  );
}
