import 'package:flutter/material.dart';

import 'vista/pantallas/consumo_pantalla.dart';
import 'vista/pantallas/detalle_pago_pantalla.dart';
import 'vista/pantallas/login_pantalla.dart';
import 'vista/tema/tema_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AquaPago',
      theme: TemaApp.tema,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPantalla(),
        '/consumo': (context) => const ConsumoPantalla(),
        '/detalle': (context) => const DetallePagoPantalla(),
      },
    );
  }
}
