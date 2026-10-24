import 'package:flutter/material.dart';

import '../atomos/campo_numero.dart';

class EntradaLecturas extends StatelessWidget {
  final TextEditingController anteriorController;
  final TextEditingController actualController;
  final FormFieldValidator<String> validarAnterior;
  final FormFieldValidator<String> validarActual;

  const EntradaLecturas({
    super.key,
    required this.anteriorController,
    required this.actualController,
    required this.validarAnterior,
    required this.validarActual,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: CampoNumero(
            controller: anteriorController,
            etiqueta: 'Lectura anterior',
            icono: Icons.history,
            sufijo: 'm³',
            validator: validarAnterior,
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: CampoNumero(
            controller: actualController,
            etiqueta: 'Lectura actual',
            icono: Icons.speed,
            sufijo: 'm³',
            validator: validarActual,
          ),
        ),
      ],
    );
  }
}
