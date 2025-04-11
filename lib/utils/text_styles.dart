import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Titres
  static const TextStyle h0 = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    fontFamily: 'poppins',
  );
  static const TextStyle h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    fontFamily: 'poppins',
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    fontFamily: 'poppins',
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: 'poppins',
  );

  // Sous-titres
  static const TextStyle subtitle1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    fontFamily: 'poppins',
  );

  static const TextStyle subtitle2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    fontFamily: 'poppins',
  );

  // Corps de texte
  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    fontFamily: 'poppins',
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    fontFamily: 'poppins',
  );

  // Boutons
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontFamily: 'poppins',
  );

  // Caption et overline
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    fontFamily: 'poppins',
  );

  static const TextStyle overline = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    fontFamily: 'poppins',
    letterSpacing: 1.5,
  );
}
