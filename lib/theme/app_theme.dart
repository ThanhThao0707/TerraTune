// lib/theme/app_theme.dart
// Định nghĩa toàn bộ màu sắc, typography và theme cho ứng dụng Terratune
// Dựa trên palette: xanh lá (#4A7C59), hồng pastel (#F8D7DA), xanh nhạt (#D4EDDA)

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary palette
  static const Color primaryGreen = Color(0xFF3D6B45);      // Xanh đậm chính
  static const Color mediumGreen = Color(0xFF5A8A62);       // Xanh vừa
  static const Color lightGreen = Color(0xFFD4EDDA);        // Xanh nhạt background card
  static const Color backgroundGreen = Color(0xFF8BB07A);   // Xanh nền chính

  // Accent
  static const Color pinkAccent = Color(0xFFF8D7DA);        // Hồng pastel header
  static const Color pinkButton = Color(0xFFF5B8C0);        // Hồng nút active

  // Status colors
  static const Color healthy = Color(0xFF4CAF50);
  static const Color drought = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFC107);

  // Neutral
  static const Color textDark = Color(0xFF2C3E1A);
  static const Color textMedium = Color(0xFF5A6B3F);
  static const Color textLight = Color(0xFF8A9B6E);
  static const Color white = Color(0xFFFFFFFF);
  static const Color cardWhite = Color(0xFFF9FBF5);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryGreen,
        primary: AppColors.primaryGreen,
        secondary: AppColors.pinkAccent,
        surface: AppColors.lightGreen,
      ),
      textTheme: GoogleFonts.dmSansTextTheme().copyWith(
        displayLarge: GoogleFonts.dmSans(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: AppColors.textDark,
        ),
        headlineMedium: GoogleFonts.dmSans(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.textDark,
        ),
        titleLarge: GoogleFonts.dmSans(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
        titleMedium: GoogleFonts.dmSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
        bodyLarge: GoogleFonts.dmSans(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: AppColors.textDark,
        ),
        bodyMedium: GoogleFonts.dmSans(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.textMedium,
        ),
        labelSmall: GoogleFonts.dmSans(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColors.textLight,
        ),
      ),
      scaffoldBackgroundColor: AppColors.backgroundGreen,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.pinkAccent,
        elevation: 0,
        titleTextStyle: GoogleFonts.dmSans(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textDark,
        ),
        iconTheme: const IconThemeData(color: AppColors.textDark),
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightGreen,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          textStyle: GoogleFonts.dmSans(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
