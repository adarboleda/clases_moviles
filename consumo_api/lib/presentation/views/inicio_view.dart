import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class InicioView extends StatelessWidget {
  const InicioView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumo de API'),
      ),

      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.lista,
            );
          },
          child: const Text('Consultar API'),
        ),
      ),
    );
  }
}