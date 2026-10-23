import 'package:flutter/material.dart';

import '../moleculas/entrada_fecha.dart';
import '../atomos/boton_calcular.dart';

class FormularioEdad extends StatelessWidget {
  final TextEditingController diaController;
  final TextEditingController mesController;
  final TextEditingController anioController;
  final VoidCallback callback;

  FormularioEdad({
    required this.diaController,
    required this.mesController,
    required this.anioController,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EntradaFecha(
          diaController: diaController,
          mesController: mesController,
          anioController: anioController,
        ),
        SizedBox(height: 12.0),
        BotonCalcular(onPressed: callback),
      ],
    );
  }
}
