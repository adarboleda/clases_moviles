import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view/pantallas/operario_pantalla.dart';
import 'view/pantallas/resultado_pantalla.dart';
import 'view_model/operario_viewmodel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => OperarioViewModel(),
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
      title: 'Operario MVVM',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const OperarioPantalla(),
        '/resultado': (context) => const ResultadoPantalla(),
      },
    );
  }
}
