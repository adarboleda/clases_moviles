import 'package:flutter/material.dart';

import '../atomos/campo_numero.dart';
import '../atomos/campo_texto.dart';

class EntradaCliente extends StatelessWidget {
  final TextEditingController cuentaController;
  final TextEditingController nombreController;
  final FormFieldValidator<String> validarCuenta;
  final FormFieldValidator<String> validarNombre;

  const EntradaCliente({
    super.key,
    required this.cuentaController,
    required this.nombreController,
    required this.validarCuenta,
    required this.validarNombre,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CampoNumero(
          controller: cuentaController,
          etiqueta: 'Número de cuenta',
          icono: Icons.badge_outlined,
          validator: validarCuenta,
          longitudMaxima: 10,
        ),
        const SizedBox(height: 16.0),
        CampoTexto(
          controller: nombreController,
          etiqueta: 'Nombre del cliente',
          icono: Icons.person_outline,
          validator: validarNombre,
          capitalizacion: TextCapitalization.words,
          longitudMaxima: 60,
        ),
      ],
    );
  }
}
