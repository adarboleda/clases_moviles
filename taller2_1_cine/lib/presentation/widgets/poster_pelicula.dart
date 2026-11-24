import 'package:flutter/material.dart';

import '../../domain/entities/pelicula.dart';

/// Póster de la película: imagen real (OMDb) o, si no hay/falla,
/// un degradado con emoji.
class PosterPelicula extends StatelessWidget {
  final Pelicula pelicula;
  final double emojiSize;
  final bool mostrarTitulo;

  const PosterPelicula({
    super.key,
    required this.pelicula,
    this.emojiSize = 72,
    this.mostrarTitulo = true,
  });

  @override
  Widget build(BuildContext context) {
    final url = pelicula.posterUrl;
    if (url == null) return _respaldo();

    return SizedBox.expand(
      child: Image.network(
        url,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progreso) =>
            progreso == null ? child : _respaldo(),
        errorBuilder: (context, error, stack) => _respaldo(),
      ),
    );
  }

  Widget _respaldo() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(pelicula.colorInicio), Color(pelicula.colorFin)],
        ),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(pelicula.emoji, style: TextStyle(fontSize: emojiSize)),
          if (mostrarTitulo) ...[
            const SizedBox(height: 12),
            Text(
              pelicula.titulo.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
