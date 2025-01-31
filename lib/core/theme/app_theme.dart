import 'package:flutter/material.dart';

import '../../app/constants/constant_theme.dart';

class AppTheme {
  AppTheme._();

  static getApplicationTheme({required bool isDarkMode}) {
    return ThemeData(
      colorScheme: isDarkMode
          ? ColorScheme.dark(
              primary: ThemeConstant.darkPrimaryColor,
              secondary:
                  ThemeConstant.accentColor, // Accent color for dark mode
            )
          : ColorScheme.light(
              primary: ThemeConstant.primaryColor,
              secondary:
                  ThemeConstant.accentColor, // Accent color for light mode
            ),
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      fontFamily: 'Montserrat',
      useMaterial3: true,

      // App Bar Color
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: ThemeConstant.primaryColor,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: ThemeConstant.primaryColor,
          textStyle: TextStyle(fontSize: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),

      // Custom TextField Theme
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        labelStyle: TextStyle(fontSize: 18, color: Colors.black54),
        prefixIconColor: Colors.black54,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ThemeConstant.primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),

      // Circular Progress Indicator Theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: ThemeConstant.primaryColor,
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ThemeConstant.primaryColor,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}
