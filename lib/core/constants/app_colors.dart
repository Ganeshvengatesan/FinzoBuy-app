import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Premium Palette - Light Mode
  static const Color lightPrimary = Color(0xFF4D43FE); // Brand royal blue/purple
  static const Color lightSecondary = Color(0xFFD4AF37); // Warm gold accent
  static const Color lightBackground = Color(0xFFF3F5F7); // Off-white background
  static const Color lightSurface = Color(0xFFFFFFFF); // Pure white
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightDivider = Color(0xFFE5E7EB); // Tailwind gray-200
  static const Color lightTextPrimary = Color(0xFF1F2937); // Tailwind gray-800
  static const Color lightTextSecondary = Color(0xFF4B5563); // Tailwind gray-600
  static const Color lightTextMuted = Color(0xFF9CA3AF); // Tailwind gray-400
  static const Color unselectedIcon = Color(0xFFB3B3B3); // Muted grey for unselected icons

  // Premium Palette - Dark Mode
  static const Color darkPrimary = Color(0xFFF3F4F6); // Soft off-white
  static const Color darkSecondary = Color(0xFFE5A93B); // Golden accent
  static const Color darkBackground = Color(0xFF121212); // Deep black/gray
  static const Color darkSurface = Color(0xFF1E1E1E); // Elevated dark surface
  static const Color darkCard = Color(0xFF2D2D2D);
  static const Color darkDivider = Color(0xFF374151); // Tailwind gray-700
  static const Color darkTextPrimary = Color(0xFFF9FAFB); // Tailwind gray-50
  static const Color darkTextSecondary = Color(0xFFD1D5DB); // Tailwind gray-300
  static const Color darkTextMuted = Color(0xFF6B7280); // Tailwind gray-500

  // Universal/Common Colors
  static const Color primaryBlue = Color(0xFF3B82F6);
  static const Color primaryGreen = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  
  static const Color transparent = Colors.transparent;
}
