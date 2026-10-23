import 'package:flutter/material.dart';

import '../atoms/campo_numero.dart';

class EntradaNumero extends StatelessWidget {
  final String etiqueta;
  final TextEditingController controller;

  const EntradaNumero({
    super.key,
    required this.etiqueta,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(etiqueta),
        SizedBox(height: 15),
        //llamar al atomo creado
        CampoNumero(controller: controller),
        SizedBox(height: 15),
      ],
    );
  }
}
