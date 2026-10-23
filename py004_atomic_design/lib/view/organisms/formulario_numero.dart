import 'package:flutter/material.dart';

import '../molecules/entrada_numero.dart';

class FormularioNumeros extends StatelessWidget {
  //mapeo
  final TextEditingController a;
  final TextEditingController b;
  final TextEditingController c;

  const FormularioNumeros({
    super.key,
    required this.a,
    required this.b,
    required this.c,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EntradaNumero(etiqueta: 'Numero a', controller: a),
        EntradaNumero(etiqueta: 'Numero b', controller: b),
        EntradaNumero(etiqueta: 'Numero c', controller: c),
      ],
    );
  }
}
