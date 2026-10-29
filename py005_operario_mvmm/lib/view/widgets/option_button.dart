import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final String titulo;
  final String valor;

  const OptionButton({super.key, required this.titulo, required this.valor});

  @override
  Widget build(BuildContext context) {
    //el valor seleccionado lo maneja el RadioGroup padre
    return RadioListTile<String>(title: Text(titulo), value: valor);
  }
}
