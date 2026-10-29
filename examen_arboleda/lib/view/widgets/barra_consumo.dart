import 'package:flutter/material.dart';

class BarraConsumo extends StatelessWidget {
  final String titulo;
  final String detalle;
  final double progreso;
  final bool excedido;

  const BarraConsumo({
    super.key,
    required this.titulo,
    required this.detalle,
    required this.progreso,
    required this.excedido,
  });

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    //rojo si supera el plan, color principal si no
    final color = excedido ? esquema.error : esquema.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(titulo, style: const TextStyle(fontWeight: FontWeight.w600)),
            const Spacer(),
            Text(
              detalle,
              style: TextStyle(color: color, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progreso,
            minHeight: 10,
            color: color,
            backgroundColor: esquema.surfaceContainerHighest,
          ),
        ),
        if (excedido)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'Superaste el límite del plan',
              style: TextStyle(color: esquema.error, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
