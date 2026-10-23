import 'package:flutter/material.dart';

class TituloTexto extends StatelessWidget {
  final String texto;

  const TituloTexto({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}
