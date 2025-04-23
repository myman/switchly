import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:switchly/core/constants/colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
      textTheme: GoogleFonts.robotoTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textColor),
        titleTextStyle: TextStyle(
          color: AppColors.textColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
