import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'AnekLatin',
      brightness: Brightness.light,
      primaryColor: AppColors.lightPrimary,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.lightPrimary,
        secondary: AppColors.lightSecondary,
        surface: AppColors.lightSurface,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: AppColors.lightTextPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.lightTextPrimary, size: AppSizes.iconMd),
        titleTextStyle: TextStyle(
          color: AppColors.lightTextPrimary,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightCard,
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: AppSizes.br12),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(double.infinity, AppSizes.buttonHeightMd),
          shape: RoundedRectangleBorder(borderRadius: AppSizes.br8),
          textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.lightPrimary,
          side: const BorderSide(color: AppColors.lightPrimary, width: 1.5),
          minimumSize: const Size(double.infinity, AppSizes.buttonHeightMd),
          shape: RoundedRectangleBorder(borderRadius: AppSizes.br8),
          textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurface,
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSizes.p16, vertical: AppSizes.p16),
        border: OutlineInputBorder(
          borderRadius: AppSizes.br8,
          borderSide: const BorderSide(color: AppColors.lightDivider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppSizes.br8,
          borderSide: const BorderSide(color: AppColors.lightDivider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSizes.br8,
          borderSide: const BorderSide(color: AppColors.lightPrimary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppSizes.br8,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        hintStyle: const TextStyle(color: AppColors.lightTextMuted, fontSize: 14.0),
        labelStyle: const TextStyle(color: AppColors.lightTextSecondary, fontSize: 14.0),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: AppColors.lightTextPrimary),
        displayMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: AppColors.lightTextPrimary),
        headlineLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: AppColors.lightTextPrimary),
        headlineMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: AppColors.lightTextPrimary),
        titleLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: AppColors.lightTextPrimary),
        titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: AppColors.lightTextPrimary),
        titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: AppColors.lightTextSecondary),
        bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, color: AppColors.lightTextPrimary),
        bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: AppColors.lightTextSecondary),
        bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: AppColors.lightTextMuted),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.lightDivider,
        thickness: 1.0,
        space: 1.0,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'AnekLatin',
      brightness: Brightness.dark,
      primaryColor: AppColors.darkPrimary,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.darkPrimary,
        secondary: AppColors.darkSecondary,
        surface: AppColors.darkSurface,
        error: AppColors.error,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: AppColors.darkTextPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.darkTextPrimary, size: AppSizes.iconMd),
        titleTextStyle: TextStyle(
          color: AppColors.darkTextPrimary,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkCard,
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: AppSizes.br12),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkPrimary,
          foregroundColor: Colors.black,
          elevation: 0,
          minimumSize: const Size(double.infinity, AppSizes.buttonHeightMd),
          shape: RoundedRectangleBorder(borderRadius: AppSizes.br8),
          textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.darkPrimary,
          side: const BorderSide(color: AppColors.darkPrimary, width: 1.5),
          minimumSize: const Size(double.infinity, AppSizes.buttonHeightMd),
          shape: RoundedRectangleBorder(borderRadius: AppSizes.br8),
          textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurface,
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSizes.p16, vertical: AppSizes.p16),
        border: OutlineInputBorder(
          borderRadius: AppSizes.br8,
          borderSide: const BorderSide(color: AppColors.darkDivider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppSizes.br8,
          borderSide: const BorderSide(color: AppColors.darkDivider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSizes.br8,
          borderSide: const BorderSide(color: AppColors.darkPrimary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppSizes.br8,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        hintStyle: const TextStyle(color: AppColors.darkTextMuted, fontSize: 14.0),
        labelStyle: const TextStyle(color: AppColors.darkTextSecondary, fontSize: 14.0),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: AppColors.darkTextPrimary),
        displayMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: AppColors.darkTextPrimary),
        headlineLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: AppColors.darkTextPrimary),
        headlineMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: AppColors.darkTextPrimary),
        titleLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: AppColors.darkTextPrimary),
        titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: AppColors.darkTextPrimary),
        titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: AppColors.darkTextSecondary),
        bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, color: AppColors.darkTextPrimary),
        bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: AppColors.darkTextSecondary),
        bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: AppColors.darkTextMuted),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.darkDivider,
        thickness: 1.0,
        space: 1.0,
      ),
    );
  }
}
