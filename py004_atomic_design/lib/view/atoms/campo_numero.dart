import 'package:flutter/material.dart';

class CampoNumero extends StatelessWidget {
  final TextEditingController controller;

  const CampoNumero({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(signed: true),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Ingrese un número',
      ),
    );
  }
}
