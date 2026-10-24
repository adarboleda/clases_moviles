import 'package:flutter/material.dart';

class BotonPrincipal extends StatelessWidget {
  final String texto;
  final IconData? icono;
  final VoidCallback onPressed;

  const BotonPrincipal({
    super.key,
    required this.texto,
    required this.onPressed,
    this.icono,
  });

  @override
  Widget build(BuildContext context) {
    if (icono == null) {
      return ElevatedButton(onPressed: onPressed, child: Text(texto));
    }
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icono),
      label: Text(texto),
    );
  }
}
