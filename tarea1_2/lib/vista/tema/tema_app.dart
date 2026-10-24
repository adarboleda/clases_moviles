import 'package:flutter/material.dart';

// Paleta de colores de la aplicación
class AppColores {
  static const Color primario = Color(0xFF0277BD);
  static const Color primarioOscuro = Color(0xFF01579B);
  static const Color secundario = Color(0xFF00ACC1);
  static const Color fondo = Color(0xFFF1F8FC);
  static const Color superficie = Colors.white;
  static const Color texto = Color(0xFF0D2A3F);
  static const Color textoSuave = Color(0xFF5B7083);
  static const Color borde = Color(0xFFB3D4E8);
  static const Color error = Color(0xFFD32F2F);
  static const Color exito = Color(0xFF2E7D32);
}

class TemaApp {
  static ThemeData get tema {
    final bordeBase = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColores.borde),
    );
    final formaBoton = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    );
    const textoBoton = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.8,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColores.primario,
        primary: AppColores.primario,
        secondary: AppColores.secundario,
        surface: AppColores.superficie,
        error: AppColores.error,
      ),
      scaffoldBackgroundColor: AppColores.fondo,

      // Tipografía
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: AppColores.primarioOscuro,
          letterSpacing: 0.5,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColores.texto,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColores.primario,
          letterSpacing: 0.3,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: AppColores.texto),
        bodyMedium: TextStyle(fontSize: 14, color: AppColores.textoSuave),
        labelLarge: textoBoton,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColores.primario,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),

      // Estilos de botones
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColores.primario,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          elevation: 2,
          shape: formaBoton,
          textStyle: textoBoton,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColores.primario,
          minimumSize: const Size.fromHeight(52),
          side: const BorderSide(color: AppColores.primario, width: 1.5),
          shape: formaBoton,
          textStyle: textoBoton,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColores.primario,
          textStyle: textoBoton,
        ),
      ),

      // Estilos de campos de entrada
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColores.superficie,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        floatingLabelStyle: WidgetStateTextStyle.resolveWith((estados) {
          if (estados.contains(WidgetState.error)) {
            return const TextStyle(color: AppColores.error);
          }
          if (estados.contains(WidgetState.focused)) {
            return const TextStyle(
              color: AppColores.primario,
              fontWeight: FontWeight.w600,
            );
          }
          return const TextStyle(color: AppColores.textoSuave);
        }),
        prefixIconColor: AppColores.primario,
        suffixIconColor: AppColores.textoSuave,
        errorMaxLines: 2,
        border: bordeBase,
        enabledBorder: bordeBase,
        focusedBorder: bordeBase.copyWith(
          borderSide: const BorderSide(color: AppColores.primario, width: 2),
        ),
        errorBorder: bordeBase.copyWith(
          borderSide: const BorderSide(color: AppColores.error),
        ),
        focusedErrorBorder: bordeBase.copyWith(
          borderSide: const BorderSide(color: AppColores.error, width: 2),
        ),
      ),

      cardTheme: CardThemeData(
        color: AppColores.superficie,
        elevation: 3,
        shadowColor: AppColores.primario.withValues(alpha: 0.25),
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColores.texto,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColores.borde,
        thickness: 1,
        space: 24,
      ),
    );
  }
}
