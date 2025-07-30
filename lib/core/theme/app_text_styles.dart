import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static final TextStyle h1 = GoogleFonts.rancho(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.neutralBlack,
  );

  static final TextStyle h2 = GoogleFonts.rancho(
    fontSize: 22,
    fontWeight: FontWeight.w600, // SemiBold
    color: AppColors.neutralBlack,
  );

  static final TextStyle body1 = GoogleFonts.rancho(
    fontSize: 18,
    fontWeight: FontWeight.w500, // Medium
    color: AppColors.neutralDarkGray,
  );

  static final TextStyle body2 = GoogleFonts.rancho(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.neutralDarkGray,
  );
}