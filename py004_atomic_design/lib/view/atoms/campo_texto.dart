import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {
  final TextEditingController controller;
  final String sugerencia;
  final IconData icono;
  final bool oculto;
  final TextInputType tipoTeclado;
  final String? error;

  const CampoTexto({
    super.key,
    required this.controller,
    required this.sugerencia,
    required this.icono,
    this.oculto = false,
    this.tipoTeclado = TextInputType.text,
    this.error,
  });

  OutlineInputBorder _borde(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: oculto,
      keyboardType: tipoTeclado,
      decoration: InputDecoration(
        hintText: sugerencia,
        hintStyle: TextStyle(fontSize: 13, color: Colors.grey[400]),
        prefixIcon: Icon(icono, size: 18, color: Colors.grey[500]),
        errorText: error,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        enabledBorder: _borde(Colors.grey[300]!),
        focusedBorder: _borde(Colors.black54),
        errorBorder: _borde(Colors.red),
        focusedErrorBorder: _borde(Colors.red),
      ),
    );
  }
}
