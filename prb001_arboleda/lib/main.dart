import 'package:flutter/material.dart';

import 'pantallas/menu_pantalla.dart';
import 'pantallas/perfecto_pantalla.dart';
import 'pantallas/fibonacci_pantalla.dart';
import 'pantallas/armstrong_pantalla.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ejercicios Arboleda',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      //pantalla principal
      home: const MenuPantalla(),
      //rutas para ir a cada ejercicio
      routes: {
        '/perfecto': (context) => const PerfectoPantalla(),
        '/fibonacci': (context) => const FibonacciPantalla(),
        '/armstrong': (context) => const ArmstrongPantalla(),
      },
    );
  }
}
