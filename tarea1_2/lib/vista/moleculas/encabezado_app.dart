import 'package:flutter/material.dart';

import '../atomos/icono_logo.dart';
import '../atomos/texto_titulo.dart';

class EncabezadoApp extends StatelessWidget {
  final String titulo;
  final String subtitulo;

  const EncabezadoApp({
    super.key,
    required this.titulo,
    required this.subtitulo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const IconoLogo(),
        const SizedBox(height: 16.0),
        TextoTitulo(texto: titulo),
        const SizedBox(height: 4.0),
        Text(subtitulo, textAlign: TextAlign.center),
      ],
    );
  }
}
