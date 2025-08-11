import 'package:flutter/material.dart';

/// App Color Palette
/// Based on Figma Design Analysis from PRD
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary Colors
  /// Dark blue-gray for headers and primary elements
  static const Color primary = Color(0xFF2E3A59);

  /// Blue for login buttons and active states
  static const Color secondary = Color(0xFF4A90E2);

  // Status Colors
  /// Green for create account and completed trips
  static const Color success = Color(0xFF27AE60);

  /// Orange for pending/scheduled states
  static const Color warning = Color(0xFFF39C12);

  /// Red for error messages and cancelled trips
  static const Color error = Color(0xFFE74C3C);

  // Background Colors
  /// White background
  static const Color backgroundWhite = Color(0xFFFFFFFF);

  /// Light gray background
  static const Color backgroundLight = Color(0xFFF8F9FA);

  /// Black background
  static const Color backgroundBlack = Color(0xFF000000);

  // Text Colors
  /// Dark text color
  static const Color textDark = Color(0xFF2C3E50);

  /// Gray text color for secondary content
  static const Color textGray = Color(0xFF7F8C8D);

  /// White text color
  static const Color textWhite = Color(0xFFFFFFFF);

  /// Black text color
  static const Color textBlack = Color(0xFF000000);

  // Additional UI Colors
  /// Border color for input fields and cards
  static const Color border = Color(0xFFBFC1C7);

  /// Shadow color for cards and elevated elements
  static const Color shadow = Color(0x1A000000);

  /// Divider color
  static const Color divider = Color(0xFFEEEEEE);

  // Trip Status Colors
  /// Upcoming trip status
  static const Color tripUpcoming = Color(0xFF4A90E2);

  /// Completed trip status
  static const Color tripCompleted = Color(0xFF27AE60);

  /// Cancelled trip status
  static const Color tripCancelled = Color(0xFFE74C3C);

  /// Scheduled trip status
  static const Color tripScheduled = Color(0xFFF39C12);

  // Gradient Colors
  /// Primary gradient start
  static const Color gradientStart = Color(0xFF4A90E2);

  /// Primary gradient end
  static const Color gradientEnd = Color(0xFF2E3A59);

  // Material Color Swatches
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

  // Helper Methods
  /// Get color by trip status
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

  /// Get contrasting text color for background
  static Color getContrastingTextColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? textDark : textWhite;
  }

  /// Create a linear gradient with primary colors
  static LinearGradient get primaryGradient =>
      const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [gradientStart, gradientEnd]);
}
