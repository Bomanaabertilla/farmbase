import 'package:flutter/material.dart';

final Color primaryGreen = const Color(0xFF2E7D32); // deep green
final Color accentBrown = const Color(0xFF6D4C41); // earthy brown
final Color backgroundLight = const Color(0xFFF1F8E9); // light green tint

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: false,
    primaryColor: primaryGreen,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: createMaterialColor(primaryGreen))
        .copyWith(secondary: accentBrown),
    scaffoldBackgroundColor: backgroundLight,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryGreen,
      foregroundColor: Colors.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentBrown,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}

/// Utility to create MaterialColor swatches from a Color
MaterialColor createMaterialColor(Color color) {
  List<double> strengths = <double>[.05];
  final swatch = <int, Color>{};
  final r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
