import 'package:flutter/material.dart';

import '../theme/app_tema.dart';

enum TipoAviso { exito, error, info }

class Aviso extends StatelessWidget {
  final String mensaje;
  final TipoAviso tipo;

  const Aviso({super.key, required this.mensaje, this.tipo = TipoAviso.info});

  @override
  Widget build(BuildContext context) {
    final (color, icono) = switch (tipo) {
      TipoAviso.exito => (AppColores.verde, Icons.check_circle_outline),
      TipoAviso.error => (AppColores.rojo, Icons.error_outline),
      TipoAviso.info => (AppColores.textoSuave, Icons.lock_outline),
    };

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icono, color: color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              mensaje,
              style: TextStyle(color: color, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
