import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view/pantallas/carrito_pantalla.dart';
import 'view/pantallas/menu_pantalla.dart';
import 'view/pantallas/splash_pantalla.dart';
import 'view_model/pedido_viewmodel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PedidoViewModel(),
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
      title: 'El Buen Sabor',
      //paleta de tonos naranjas
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE65100))
            .copyWith(primary: const Color(0xFFD84315)),
        scaffoldBackgroundColor: const Color(0xFFFFF8F3),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFBF360C),
          foregroundColor: Colors.white,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPantalla(),
        '/menu': (context) => const MenuPantalla(),
        '/carrito': (context) => const CarritoPantalla(),
      },
    );
  }
}
