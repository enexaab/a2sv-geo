
import 'package:a2sv_geo/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        primaryColor: AppConstants.primaryColor,
        scaffoldBackgroundColor: AppConstants.backgroundColor,
        cardTheme: const CardThemeData(
          color: AppConstants.cardBackground,
          elevation: 1,
          surfaceTintColor: AppConstants.cardBackground,
        ),
        fontFamily: 'PlusJakartaSans',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: AppConstants.primaryColor,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppConstants.backgroundColor,
          selectedItemColor: AppConstants.primaryColor,
          unselectedItemColor: AppConstants.textSecondary,
          type: BottomNavigationBarType.fixed,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConstants.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppConstants.searchBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintStyle: const TextStyle(color: AppConstants.textSecondary),
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: AppConstants.textPrimary,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            color: AppConstants.textPrimary,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(color: AppConstants.textPrimary),
          bodyMedium: TextStyle(color: AppConstants.textSecondary),
          labelMedium: TextStyle(color: AppConstants.textPrimary),
        ).apply(fontFamily: 'PlusJakartaSans'),
        chipTheme: ChipThemeData(
          backgroundColor: Colors.white,
          labelStyle: const TextStyle(color: AppConstants.textPrimary),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        dialogTheme: const DialogThemeData(
          backgroundColor: AppConstants.backgroundColor,
          titleTextStyle: TextStyle(
            color: AppConstants.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Colors.black87,
          contentTextStyle: TextStyle(color: Colors.white),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppConstants.primaryColor,
          brightness: Brightness.light,
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        primaryColor: AppConstants.primaryColor,
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardTheme: const CardThemeData(
          color: Color(0xFF1E1E1E),
          elevation: 1,
          surfaceTintColor: Color(0xFF1E1E1E),
        ),
        fontFamily: 'PlusJakartaSans',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          foregroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Color(0xFF1E1E1E),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1E1E1E),
          selectedItemColor: AppConstants.primaryColor,
          unselectedItemColor: Color(0xFF9E9E9E),
          type: BottomNavigationBarType.fixed,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConstants.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF2D2D2D),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintStyle: const TextStyle(color: Color(0xFF9E9E9E)),
          labelStyle: const TextStyle(color: Colors.white),
          floatingLabelStyle: const TextStyle(color: AppConstants.primaryColor),
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Color(0xFF9E9E9E)),
          labelMedium: TextStyle(color: Colors.white),
        ).apply(fontFamily: 'PlusJakartaSans'),
        chipTheme: ChipThemeData(
          backgroundColor: const Color(0xFF2D2D2D),
          labelStyle: const TextStyle(color: Colors.white),
          side: BorderSide(color: Colors.grey.shade700),
          selectedColor: AppConstants.primaryColor,
          checkmarkColor: Colors.white,
        ),
        dialogTheme: const DialogThemeData(
          backgroundColor: Color(0xFF1E1E1E),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          contentTextStyle: TextStyle(color: Colors.white),
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color(0xFF2D2D2D),
          contentTextStyle: TextStyle(color: Colors.white),
        ),
        listTileTheme: const ListTileThemeData(
          tileColor: Color(0xFF1E1E1E),
          textColor: Colors.white,
          iconColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppConstants.primaryColor,
          brightness: Brightness.dark,
          // ignore: deprecated_member_use
          background: const Color(0xFF121212),
          surface: const Color(0xFF1E1E1E),
          onSurface: Colors.white,
        ),
        dividerTheme: const DividerThemeData(
          color: Color(0xFF2D2D2D),
        ),
      );
}