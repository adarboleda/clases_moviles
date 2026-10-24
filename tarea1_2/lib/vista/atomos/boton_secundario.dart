import 'package:flutter/material.dart';

class BotonSecundario extends StatelessWidget {
  final String texto;
  final IconData? icono;
  final VoidCallback onPressed;

  const BotonSecundario({
    super.key,
    required this.texto,
    required this.onPressed,
    this.icono,
  });

  @override
  Widget build(BuildContext context) {
    if (icono == null) {
      return OutlinedButton(onPressed: onPressed, child: Text(texto));
    }
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icono),
      label: Text(texto),
    );
  }
}
