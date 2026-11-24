import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Bienvenido a la aplicación de fotos',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
