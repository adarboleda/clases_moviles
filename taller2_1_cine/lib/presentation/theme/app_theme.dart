import 'package:flutter/material.dart';

/// Paleta inspirada en la app de Multicines (oscuro + amarillo).
class AppColors {
  static const fondo = Color(0xFF14151A);
  static const tarjeta = Color(0xFF262A36);
  static const acento = Color(0xFFFBB024);
  static const rojo = Color(0xFFD9534F);
  static const textoSecundario = Color(0xFF9AA0B4);
}

class AppTheme {
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.fondo,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.acento,
          onPrimary: Colors.black,
          surface: AppColors.tarjeta,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.fondo,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.fondo,
          selectedItemColor: AppColors.acento,
          unselectedItemColor: AppColors.textoSecundario,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
        ),
      );
}
