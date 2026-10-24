import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CampoNumero extends StatelessWidget {
  final TextEditingController controller;
  final String etiqueta;
  final IconData icono;
  final FormFieldValidator<String>? validator;
  final String? sufijo;
  final int longitudMaxima;

  const CampoNumero({
    super.key,
    required this.controller,
    required this.etiqueta,
    required this.icono,
    this.validator,
    this.sufijo,
    this.longitudMaxima = 7,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      maxLength: longitudMaxima,
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      decoration: InputDecoration(
        labelText: etiqueta,
        prefixIcon: Icon(icono),
        suffixText: sufijo,
        counterText: '',
      ),
    );
  }
}
