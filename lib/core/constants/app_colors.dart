import 'package:flutter/material.dart';

class AppColors {
  // Couleurs principales inspirées du poulet grillé
  static const Color primary = Color(0xFFD35400); // Orange chaleureux
  static const Color secondary = Color(0xFF8B4513); // Marron cuivré
  static const Color accent = Color(0xFFFFA726); // Orange doré
  static const Color background = Color(0xFFFEF9E7); // Beige très clair
  static const Color surface = Color(0xFFFFFFFF); // Blanc
  static const Color textPrimary = Color(0xFF2C3E50); // Gris foncé
  static const Color textSecondary = Color(0xFF7F8C8D); // Gris moyen
  static const Color success = Color(0xFF27AE60); // Vert
  static const Color error = Color(0xFFE74C3C); // Rouge
  static const Color warning = Color(0xFFF39C12); // Orange

  // Dégradés
  static LinearGradient primaryGradient = const LinearGradient(
    colors: [primary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
