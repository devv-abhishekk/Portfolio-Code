import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const background = Color(0xFF030712);
  static const surface = Color(0xFF111827);
  static const sideBar = Color(0xFF0F172A);
  static const primary = Color(0xFF6366F1);
  static const primaryLight = Color(0xFF818CF8);
  static const primaryGlow = Color(0x336366F1);
  static const accent = Color(0xFF22D3EE);
  static const accentGlow = Color(0x2222D3EE);
  static const onBackground = Color(0xFFF8FAFC);
  static const onSurface = Color(0xFF94A3B8);
  static const border = Color(0xFF1E293B);
  static const cardGlass = Color(0x0F8892B0);
  static const glassBorder = Color(0x1AFFFFFF);
  static const success = Color(0xFF10B981);
  static const neonPink = Color(0xFFFF2D55);
  static const neonPurple = Color(0xFFBF5AF2);
  
  // Premium Gradients
  static const primaryGradient = LinearGradient(
    colors: [primary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static final glassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white.withValues(alpha: 0.1),
      Colors.white.withValues(alpha: 0.05),
    ],
  );
}

class AppTheme {
  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.surface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.onBackground,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
        displayLarge: GoogleFonts.plusJakartaSans(
          fontSize: 64,
          fontWeight: FontWeight.w800,
          color: AppColors.onBackground,
          letterSpacing: -2,
        ),
        displayMedium: GoogleFonts.plusJakartaSans(
          fontSize: 48,
          fontWeight: FontWeight.w800,
          color: AppColors.onBackground,
          letterSpacing: -1,
        ),
        displaySmall: GoogleFonts.plusJakartaSans(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AppColors.onBackground,
        ),
        headlineMedium: GoogleFonts.plusJakartaSans(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.onBackground,
        ),
        bodyLarge: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          color: AppColors.onSurface,
          height: 1.6,
        ),
        bodyMedium: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          color: AppColors.onSurface,
          height: 1.5,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: AppColors.border.withValues(alpha: 0.5), width: 1),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.border.withValues(alpha: 0.5),
        thickness: 1,
      ),
    );
  }
}
