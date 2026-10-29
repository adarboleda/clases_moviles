import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view/pantallas/inicio_pantalla.dart';
import 'view/pantallas/principal_pantalla.dart';
import 'view/pantallas/resultado_pantalla.dart';
import 'view_model/consumo_viewmodel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ConsumoViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Control de Consumo',
      //paleta de tonos azules
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0078D4))
            .copyWith(
              primary: const Color(0xFF0078D4), //themePrimary
              onPrimary: Colors.white,
              primaryContainer: const Color(0xFFC7E0F4), //themeLight
              onPrimaryContainer: const Color(0xFF004578), //themeDarker
              secondary: const Color(0xFF2B88D8), //themeSecondary
              onSecondary: Colors.white,
              secondaryContainer: const Color(0xFFDEECF9), //themeLighter
              onSecondaryContainer: const Color(0xFF004578), //themeDarker
              tertiary: const Color(0xFF71AFE5), //themeTertiary
              surface: Colors.white,
              surfaceContainerLow: const Color(0xFFEFF6FC), //themeLighterAlt
              surfaceContainerHighest: const Color(0xFFDEECF9), //themeLighter
            ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF005A9E), //themeDark
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const InicioPantalla(),
        '/principal': (context) => const PrincipalPantalla(),
        '/resultado': (context) => const ResultadoPantalla(),
      },
    );
  }
}
