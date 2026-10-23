import 'package:flutter/material.dart';

class EtiquetaTexto extends StatelessWidget {
  final String texto;

  const EtiquetaTexto({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Text(texto, style: TextStyle(fontSize: 13, color: Colors.grey[700]));
  }
}
