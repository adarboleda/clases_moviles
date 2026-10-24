import 'package:flutter/material.dart';

import '../tema/tema_app.dart';
import '../utilidades/formato.dart';

class ResumenTotal extends StatelessWidget {
  final double total;
  final int consumo;

  const ResumenTotal({super.key, required this.total, required this.consumo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [AppColores.primarioOscuro, AppColores.secundario],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const Text(
            'TOTAL A PAGAR',
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            formatoMoneda(total),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.water_drop, color: Colors.white70, size: 18),
              const SizedBox(width: 4.0),
              Text(
                'Consumo del período: $consumo m³',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
