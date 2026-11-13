import 'package:flutter/material.dart';

import '../../domain/entities/libro.dart';
import 'etiqueta_stock.dart';
import 'portada_libro.dart';

class TarjetaLibroLista extends StatelessWidget {
  final Libro libro;
  final VoidCallback onDetalle;

  const TarjetaLibroLista({
    super.key,
    required this.libro,
    required this.onDetalle,
  });

  @override
  Widget build(BuildContext context) {
    final textos = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onDetalle,
          child: PortadaLibro(
            url: libro.portadaUrl,
            titulo: libro.titulo,
            ancho: 104,
            alto: 152,
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                libro.titulo,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textos.titleLarge?.copyWith(fontSize: 18, height: 1.3),
              ),
              const SizedBox(height: 4),
              Text(
                libro.autor,
                style: textos.bodyMedium?.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                '${libro.categoria} · ${libro.anio}',
                style: textos.bodyMedium?.copyWith(fontSize: 12),
              ),
              const SizedBox(height: 10),
              EtiquetaStock(libro: libro),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: onDetalle,
                style: FilledButton.styleFrom(minimumSize: const Size(112, 40)),
                child: const Text('Detalle'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
