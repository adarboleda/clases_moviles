import 'package:flutter/material.dart';

//paleta basada en la referencia: verde azulado y naranja sobre fondo claro
class AppColores {
  static const Color verde = Color(0xFF4AA79B);
  static const Color verdeOscuro = Color(0xFF3A8B80);
  static const Color verdeClaro = Color(0xFFE3F2F0);
  static const Color naranja = Color(0xFFF47C51);
  static const Color fondo = Color(0xFFF6F7F9);
  static const Color superficie = Colors.white;
  static const Color gris = Color(0xFFEFF1F4);
  static const Color texto = Color(0xFF2B2D42);
  static const Color textoSuave = Color(0xFF8D8FA0);
  static const Color rojo = Color(0xFFE5534B);
  static const Color estrella = Color(0xFFF7C744);
}

class AppTema {
  static ThemeData get tema {
    final forma = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColores.verde).copyWith(
        primary: AppColores.verde,
        secondary: AppColores.naranja,
        surface: AppColores.superficie,
        error: AppColores.rojo,
      ),
      scaffoldBackgroundColor: AppColores.fondo,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColores.fondo,
        foregroundColor: AppColores.texto,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColores.texto,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          color: AppColores.texto,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: AppColores.texto,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: AppColores.texto,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(color: AppColores.texto, fontSize: 15),
        bodyMedium: TextStyle(color: AppColores.textoSuave, fontSize: 13),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColores.naranja,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColores.gris,
          minimumSize: const Size(0, 48),
          shape: forma,
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColores.verde,
          side: const BorderSide(color: AppColores.verde),
          minimumSize: const Size(0, 48),
          shape: forma,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColores.gris,
        hintStyle: const TextStyle(color: AppColores.textoSuave),
        prefixIconColor: AppColores.textoSuave,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColores.verde, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColores.rojo),
        ),
        errorMaxLines: 2,
      ),
      cardTheme: CardThemeData(
        color: AppColores.superficie,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColores.superficie,
        selectedColor: AppColores.verde,
        side: const BorderSide(color: AppColores.gris),
        labelStyle: const TextStyle(color: AppColores.texto),
        secondaryLabelStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        showCheckmark: false,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColores.superficie,
        indicatorColor: AppColores.verdeClaro,
        surfaceTintColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (estados) => TextStyle(
            fontSize: 12,
            color: estados.contains(WidgetState.selected)
                ? AppColores.naranja
                : AppColores.textoSuave,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (estados) => IconThemeData(
            color: estados.contains(WidgetState.selected)
                ? AppColores.naranja
                : AppColores.textoSuave,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColores.naranja,
        foregroundColor: Colors.white,
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColores.texto,
      ),
    );
  }
}
