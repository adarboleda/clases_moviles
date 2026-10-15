import 'package:flutter/material.dart';

class NumeroPantalla extends StatelessWidget {
  const NumeroPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Números'),
      ),
      body: const Center(
        child: Text('Pantalla de números'),
      ),
    );
  }
}