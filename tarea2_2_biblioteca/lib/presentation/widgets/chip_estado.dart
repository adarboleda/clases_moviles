import 'package:flutter/material.dart';

import '../theme/app_tema.dart';
import '../viewmodels/prestamo_viewmodel.dart';

class ChipEstado extends StatelessWidget {
  final EstadoVisible estado;

  const ChipEstado({super.key, required this.estado});

  static Color colorDe(EstadoVisible estado) {
    switch (estado) {
      case EstadoVisible.activo:
        return AppColores.verde;
      case EstadoVisible.vencido:
        return AppColores.rojo;
      case EstadoVisible.devuelto:
        return AppColores.textoSuave;
    }
  }

  static String textoDe(EstadoVisible estado) {
    switch (estado) {
      case EstadoVisible.activo:
        return 'Activo';
      case EstadoVisible.vencido:
        return 'Vencido';
      case EstadoVisible.devuelto:
        return 'Devuelto';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = colorDe(estado);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        textoDe(estado),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
