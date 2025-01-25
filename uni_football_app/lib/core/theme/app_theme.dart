import 'package:flutter/material.dart';

import '../../app/constants/constant_theme.dart';


class AppTheme {
  AppTheme._();

  static getApplicationTheme({required bool isDarkMode}) {
    return ThemeData(
      colorScheme: isDarkMode
          ? const ColorScheme.dark(
              primary: ThemeConstant.darkPrimaryColor,
            )
          : const ColorScheme.light(
              primary: ThemeConstant.primaryColor,
            ),
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      fontFamily: 'Montserrat',
      useMaterial3: true,

      // Change app bar color
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: ThemeConstant.appBarColor,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),

      ),

      // Change elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: ThemeConstant.primaryColor,
          textStyle: const TextStyle(
            fontSize: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),

      // Change text field theme
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.all(12),
        border: OutlineInputBorder(),
        labelStyle: TextStyle(
          fontSize: 18,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ThemeConstant.primaryColor,
          ),
        ),
      ),
      // Circular progress bar theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: ThemeConstant.primaryColor,
      ),
      //Bottom navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: ThemeConstant.primaryColor,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}
