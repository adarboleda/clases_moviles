import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/foto_provider.dart';
import 'view/foto_view.dart';
import 'view/home_view.dart';
import 'view/perfil_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => FotoProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;

  final screen = const [HomeView(), PerfilView(), FotoView()];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: screen[index],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          onTap: (i) => setState(() => index = i),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
            BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'Fotos'),
          ],
        ),
      ),
    );
  }
}
