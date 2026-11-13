import 'package:flutter/material.dart';

import '../theme/app_tema.dart';

//fila de datos separados por lineas, como "Disponibles | Paginas | Año"
class FilaDatos extends StatelessWidget {
  final List<(String, String)> datos;

  const FilaDatos({super.key, required this.datos});

  @override
  Widget build(BuildContext context) {
    final columnas = <Widget>[];
    for (var i = 0; i < datos.length; i++) {
      final (titulo, valor) = datos[i];
      if (i > 0) {
        columnas.add(
          const VerticalDivider(width: 1, thickness: 1, color: Colors.white),
        );
      }
      columnas.add(
        Expanded(
          child: Column(
            children: [
              Text(titulo, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 4),
              Text(
                valor,
                style: const TextStyle(
                  color: AppColores.texto,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColores.gris,
        borderRadius: BorderRadius.circular(14),
      ),
      child: IntrinsicHeight(child: Row(children: columnas)),
    );
  }
}
