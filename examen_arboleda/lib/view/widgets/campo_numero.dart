import 'package:flutter/material.dart';

class CampoNumero extends StatelessWidget {
  final String etiqueta;
  final String sufijo;
  final IconData icono;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String? error;
  final bool decimal;

  const CampoNumero({
    super.key,
    required this.etiqueta,
    required this.sufijo,
    required this.icono,
    required this.controller,
    required this.onChanged,
    this.error,
    this.decimal = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: TextInputType.numberWithOptions(decimal: decimal),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: etiqueta,
        prefixIcon: Icon(icono),
        suffixText: sufijo,
        errorText: error,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
