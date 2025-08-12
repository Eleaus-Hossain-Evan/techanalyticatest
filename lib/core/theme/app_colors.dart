import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF2E3A59);
  static const Color secondary = Color(0xFF4A90E2);
  static const Color success = Color(0xFF27AE60);
  static const Color warning = Color(0xFFF39C12);
  static const Color error = Color(0xFFE74C3C);

  static const Color white = Color(0xFFFFFFFF);
  static const Color white50 = Color(0xFFF9F9F9);
  static const Color black = Color(0xFF000000);

  static const Color primary50 = Color(0xFFFEE8E7);

  static const Color backgroundLight = Color(0xFFF8F9FA);

  static const Color textDark = Color(0xFF2C3E50);
  static const Color textGray = Color(0xFF7F8C8D);

  static const Color border = Color(0xFFBFC1C7);
  static const Color shadow = Color(0x1A000000);
  static const Color divider = Color(0xFFEEEEEE);

  static const Color tripUpcoming = Color(0xFF4A90E2);

  static const Color tripCompleted = Color(0xFF27AE60);

  static const Color tripCancelled = Color(0xFFE74C3C);

  static const Color tripScheduled = Color(0xFFF39C12);

  static const Color gradientStart = Color(0xFF4A90E2);

  static const Color gradientEnd = Color(0xFF2E3A59);

  static const MaterialColor primarySwatch = MaterialColor(0xFF2E3A59, <int, Color>{
    50: Color(0xFFE6E9ED),
    100: Color(0xFFC0C7D2),
    200: Color(0xFF96A2B4),
    300: Color(0xFF6C7C96),
    400: Color(0xFF4D6080),
    500: Color(0xFF2E3A59),
    600: Color(0xFF293551),
    700: Color(0xFF232D47),
    800: Color(0xFF1D263D),
    900: Color(0xFF121A2D),
  });

  static Color getColorByTripStatus(String status) {
    switch (status.toLowerCase()) {
      case 'upcoming':
        return tripUpcoming;
      case 'completed':
      case 'past':
        return tripCompleted;
      case 'cancelled':
        return tripCancelled;
      case 'scheduled':
        return tripScheduled;
      default:
        return textGray;
    }
  }

  static Color getContrastingTextColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? textDark : white;
  }

  static LinearGradient get primaryGradient =>
      const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [gradientStart, gradientEnd]);
}
