import 'package:flutter/material.dart';

import '../../domain/entities/libro.dart';
import 'portada_libro.dart';

class TarjetaLibroCarrusel extends StatelessWidget {
  final Libro libro;
  final VoidCallback onTap;

  static const double ancho = 128;

  const TarjetaLibroCarrusel({
    super.key,
    required this.libro,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textos = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: ancho,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PortadaLibro(
              url: libro.portadaUrl,
              titulo: libro.titulo,
              ancho: ancho,
              alto: 182,
            ),
            const SizedBox(height: 12),
            Text(
              libro.autor,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textos.bodyMedium?.copyWith(fontSize: 12),
            ),
            const SizedBox(height: 2),
            Text(
              libro.titulo,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textos.titleMedium?.copyWith(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
