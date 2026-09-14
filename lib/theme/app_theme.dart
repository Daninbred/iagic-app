import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tokens de diseño de IAGIC — sistema v2, valores confirmados por
/// extracción de píxel del Figma real (documento de Foundations, hilo UI/UX).
class AppColors {
  // Neutros
  static const Color background = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color border = Color(0xFFE5E7EB);

  // Degradado primario / interactivo (bordes de botón, logo)
  static const Color gradientStart = Color(0xFF9515F6);
  static const Color gradientEnd = Color(0xFF0E68D4);

  // Degradado de progreso / estado (barra de progreso del onboarding)
  static const Color progressGradientStart = Color(0xFFA243E1);
  static const Color progressGradientEnd = Color(0xFFEA7E8D);
  static const Color progressTrack = Color(0xFFE5E0EB);

  // Morado suave (links, "¿Tienes dudas?")
  static const Color linkSoft = Color(0xFFAD7ED2);

  // Fondo degradado (SOLO Splash / Registro / Login)
  static const Color authGradientStart = Color(0xFFFEF7F8);
  static const Color authGradientMid = Color(0xFFE1BFFC);
  static const Color authGradientEnd = Color(0xFFE5CCFB);

  // Semánticos
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
}

class AppGradients {
  static const LinearGradient primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.gradientStart, AppColors.gradientEnd],
  );

  static const LinearGradient progress = LinearGradient(
    colors: [AppColors.progressGradientStart, AppColors.progressGradientEnd],
  );

  static const LinearGradient authBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.authGradientStart,
      AppColors.authGradientMid,
      AppColors.authGradientEnd,
    ],
  );
}

class AppTextStyles {
  static TextStyle get tituloGrande => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get tituloMediano => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get cuerpo => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      );

  static TextStyle get secundario => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  static TextStyle get caption => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: GoogleFonts.poppins().fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.gradientStart,
      primary: AppColors.gradientStart,
      secondary: AppColors.gradientEnd,
      error: AppColors.error,
    ),
  );
}
