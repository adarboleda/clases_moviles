import 'package:flutter/material.dart';

import '../theme/app_tema.dart';

class PortadaLibro extends StatelessWidget {
  final String url;
  final String titulo;
  final double ancho;
  final double alto;
  final double radio;
  final bool sombra;

  const PortadaLibro({
    super.key,
    required this.url,
    required this.titulo,
    required this.ancho,
    required this.alto,
    this.radio = 10,
    this.sombra = true,
  });

  @override
  Widget build(BuildContext context) {
    final generada = _PortadaGenerada(titulo: titulo, ancho: ancho);

    return Container(
      width: ancho,
      height: alto,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radio),
        boxShadow: sombra
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.18),
                  blurRadius: 14,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radio),
        child: url.isEmpty
            ? generada
            : Image.network(
                url,
                width: ancho,
                height: alto,
                fit: BoxFit.cover,
                //si la imagen no carga se muestra una portada con el titulo
                errorBuilder: (context, error, stackTrace) => generada,
                loadingBuilder: (context, child, progreso) => progreso == null
                    ? child
                    : Container(color: AppColores.gris),
              ),
      ),
    );
  }
}

class _PortadaGenerada extends StatelessWidget {
  final String titulo;
  final double ancho;

  const _PortadaGenerada({required this.titulo, required this.ancho});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ancho * 0.1),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColores.verde, AppColores.verdeOscuro],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.menu_book, color: Colors.white70, size: ancho * 0.25),
          SizedBox(height: ancho * 0.06),
          Text(
            titulo,
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: (ancho * 0.11).clamp(8, 18),
            ),
          ),
        ],
      ),
    );
  }
}
