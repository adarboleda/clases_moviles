import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {
  final TextEditingController controller;
  final String etiqueta;
  final IconData icono;
  final FormFieldValidator<String>? validator;
  final TextCapitalization capitalizacion;
  final int? longitudMaxima;

  const CampoTexto({
    super.key,
    required this.controller,
    required this.etiqueta,
    required this.icono,
    this.validator,
    this.capitalizacion = TextCapitalization.none,
    this.longitudMaxima,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textCapitalization: capitalizacion,
      maxLength: longitudMaxima,
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      decoration: InputDecoration(
        labelText: etiqueta,
        prefixIcon: Icon(icono),
        counterText: '',
      ),
    );
  }
}
