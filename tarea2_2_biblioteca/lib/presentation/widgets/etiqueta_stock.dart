import 'package:flutter/material.dart';

import '../../domain/entities/libro.dart';
import '../theme/app_tema.dart';

class EtiquetaStock extends StatelessWidget {
  final Libro libro;

  const EtiquetaStock({super.key, required this.libro});

  @override
  Widget build(BuildContext context) {
    final color = libro.disponible ? AppColores.verde : AppColores.rojo;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.inventory_2_outlined, size: 16, color: color),
        const SizedBox(width: 6),
        Text(
          libro.disponible
              ? '${libro.stockDisponible} de ${libro.stockTotal} disponibles'
              : 'Sin stock',
          style: TextStyle(color: color, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
