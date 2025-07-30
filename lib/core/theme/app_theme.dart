import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        background: AppColors.backgroundSupport,
        onBackground: AppColors.neutralBlack,
        surface: AppColors.primaryPale,
        onSurface: AppColors.neutralBlack,
      ),
      scaffoldBackgroundColor: AppColors.backgroundSupport,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundSupport,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.rancho(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.neutralBlack,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.neutralBlack,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.h1,
        displayMedium: AppTextStyles.h2,
        bodyLarge: AppTextStyles.body1,
        bodyMedium: AppTextStyles.body2,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.neutralBlack,
          textStyle: AppTextStyles.body1.copyWith(fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 2),
          textStyle: AppTextStyles.body1.copyWith(fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTextStyles.body1.copyWith(fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}