import 'package:flutter/material.dart';

import '../theme/app_tema.dart';

class SeccionTitulo extends StatelessWidget {
  final String titulo;
  final String? accion;
  final VoidCallback? onAccion;
  final Color color;

  const SeccionTitulo({
    super.key,
    required this.titulo,
    this.accion,
    this.onAccion,
    this.color = AppColores.texto,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            titulo,
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(color: color),
          ),
        ),
        if (accion != null)
          TextButton(
            onPressed: onAccion,
            style: TextButton.styleFrom(
              foregroundColor: color == AppColores.texto
                  ? AppColores.naranja
                  : color,
            ),
            child: Text(accion!),
          ),
      ],
    );
  }
}
