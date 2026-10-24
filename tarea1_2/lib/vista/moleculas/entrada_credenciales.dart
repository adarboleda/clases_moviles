import 'package:flutter/material.dart';

import '../atomos/campo_clave.dart';
import '../atomos/campo_texto.dart';

class EntradaCredenciales extends StatelessWidget {
  final TextEditingController usuarioController;
  final TextEditingController claveController;
  final FormFieldValidator<String> validarUsuario;
  final FormFieldValidator<String> validarClave;
  final VoidCallback onEnviar;

  const EntradaCredenciales({
    super.key,
    required this.usuarioController,
    required this.claveController,
    required this.validarUsuario,
    required this.validarClave,
    required this.onEnviar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CampoTexto(
          controller: usuarioController,
          etiqueta: 'Usuario',
          icono: Icons.person_outline,
          validator: validarUsuario,
          longitudMaxima: 20,
        ),
        const SizedBox(height: 16.0),
        CampoClave(
          controller: claveController,
          validator: validarClave,
          onEnviar: onEnviar,
        ),
      ],
    );
  }
}
