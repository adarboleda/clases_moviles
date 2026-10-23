import 'package:flutter/material.dart';

import 'vista/pantallas/edad_pantalla.dart';
import 'vista/pantallas/resultado_pantalla.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora de Edad',
      initialRoute: '/',
      routes: {
        '/': (context) => EdadPantalla(),
        '/resultado': (context) => ResultadoEdad(),
      },
    );
  }
}
