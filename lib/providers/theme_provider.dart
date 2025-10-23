import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/themes/app_theme.dart';

// État du thème
class ThemeState {
  final ThemeMode themeMode;

  ThemeState(this.themeMode);

  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(themeMode ?? this.themeMode);
  }
}

// Notifier pour gérer le thème
class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier() : super(ThemeState(ThemeMode.light));

  // Charger le thème depuis les préférences
  Future<void> loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeIndex = prefs.getInt('theme_mode') ?? 0;
      final themeMode = ThemeMode.values[themeIndex];
      state = ThemeState(themeMode);
    } catch (e) {
      // Garder le thème par défaut en cas d'erreur
      state = ThemeState(ThemeMode.light);
    }
  }

  // Changer le thème
  Future<void> toggleTheme() async {
    final newThemeMode =
        state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

    state = state.copyWith(themeMode: newThemeMode);

    // Sauvegarder dans les préférences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme_mode', newThemeMode.index);
  }

  // Définir le thème explicitement
  Future<void> setTheme(ThemeMode themeMode) async {
    state = state.copyWith(themeMode: themeMode);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme_mode', themeMode.index);
  }
}

// Providers
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});

final currentThemeProvider = Provider<ThemeData>((ref) {
  final themeState = ref.watch(themeProvider);

  return themeState.themeMode == ThemeMode.dark
      ? _darkTheme
      : AppTheme.lightTheme;
});

// Thème sombre personnalisé
final ThemeData _darkTheme = ThemeData(
  primaryColor: const Color(0xFFBB86FC),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFBB86FC),
    secondary: Color(0xFF03DAC6),
    background: Color(0xFF121212),
    surface: Color(0xFF1E1E1E),
    onPrimary: Colors.black,
    onSecondary: Colors.black,
  ),
  scaffoldBackgroundColor: const Color(0xFF121212),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displayMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: Colors.white70,
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  cardTheme: CardThemeData(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    color: const Color(0xFF1E1E1E),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF2C2C2C),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
    labelStyle: const TextStyle(color: Colors.white70),
    hintStyle: const TextStyle(color: Colors.white54),
  ),
);
