import 'package:flutter/material.dart';

import '../tema/tema_app.dart';

class IconoLogo extends StatelessWidget {
  final double tamanio;

  const IconoLogo({super.key, this.tamanio = 96});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: tamanio,
      height: tamanio,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [AppColores.secundario, AppColores.primarioOscuro],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColores.primario.withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Icon(Icons.water_drop, color: Colors.white, size: tamanio * 0.55),
    );
  }
}
