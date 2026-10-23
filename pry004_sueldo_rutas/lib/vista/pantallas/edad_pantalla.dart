import 'package:flutter/material.dart';

import '../../controlador/edad_controlador.dart';
import '../organismos/formulario_edad.dart';

class EdadPantalla extends StatefulWidget {
  //superkey
  EdadPantalla({super.key});
  @override
  State<EdadPantalla> createState() => _EdadPantallaState();
}

class _EdadPantallaState extends State<EdadPantalla> {
  final TextEditingController diaController = TextEditingController();
  final TextEditingController mesController = TextEditingController();
  final TextEditingController anioController = TextEditingController();
  final EdadControlador controlador = EdadControlador();

  String resultado = '';

  void calcularEdad() {
    int dia = int.parse(diaController.text);
    int mes = int.parse(mesController.text);
    int anio = int.parse(anioController.text);
    final resultado = controlador.calcularEdad(dia, mes, anio);

    //paso de parametros
    Navigator.pushNamed(
      context,
      '/resultado',
      arguments: {
        'anios': resultado.anios,
        'meses': resultado.meses,
        'dias': resultado.dias,
      },
    );
  }

  /*
  void calcular(){
    final resultado = controlador.calcularSueldo(sueldo.text, bono.text, horas.text);
    Navigator.pushNamed(
      context,
      '/resultado',
      arguments: {
        'sueldo': resultado.sueldo,
        'bono': resultado.bono,
        'horas': resultado.horas,
        'total': resultado.total,
      },
    );
  }

  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora edad'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            FormularioEdad(
              diaController: diaController,
              mesController: mesController,
              anioController: anioController,
              callback: calcularEdad,
            ),
          ],
        ),
      ),
    );
  }
}
