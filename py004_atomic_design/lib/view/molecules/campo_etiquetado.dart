import 'package:flutter/material.dart';

import '../atoms/campo_texto.dart';
import '../atoms/etiqueta_texto.dart';

class CampoEtiquetado extends StatelessWidget {
  final String etiqueta;
  final String sugerencia;
  final IconData icono;
  final TextEditingController controller;
  final bool oculto;
  final TextInputType tipoTeclado;
  final String? error;

  const CampoEtiquetado({
    super.key,
    required this.etiqueta,
    required this.sugerencia,
    required this.icono,
    required this.controller,
    this.oculto = false,
    this.tipoTeclado = TextInputType.text,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //llamar a los atomos creados
        EtiquetaTexto(texto: etiqueta),
        const SizedBox(height: 6),
        CampoTexto(
          controller: controller,
          sugerencia: sugerencia,
          icono: icono,
          oculto: oculto,
          tipoTeclado: tipoTeclado,
          error: error,
        ),
      ],
    );
  }
}
