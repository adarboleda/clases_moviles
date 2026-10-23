import 'package:flutter/material.dart';

import '../atomos/campo_numero.dart';

class EntradaFecha extends StatelessWidget {
  final TextEditingController diaController;
  final TextEditingController mesController;
  final TextEditingController anioController;

  EntradaFecha({
    required this.diaController,
    required this.mesController,
    required this.anioController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CampoNumero(controller: diaController, etiqueta: 'Día'),
        SizedBox(height: 10.0),
        CampoNumero(controller: mesController, etiqueta: 'Mes'),
        SizedBox(height: 10.0),
        CampoNumero(controller: anioController, etiqueta: 'Año'),
      ],
    );
  }
}
