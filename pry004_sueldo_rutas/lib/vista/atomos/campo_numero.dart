import 'package:flutter/material.dart';

class CampoNumero extends StatelessWidget {
  final TextEditingController controller;
  final String etiqueta;

  CampoNumero({required this.controller, required this.etiqueta});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: etiqueta,
        border: OutlineInputBorder(),
      ),
    );
  }
}
