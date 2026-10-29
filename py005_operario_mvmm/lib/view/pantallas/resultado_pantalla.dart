import 'package:flutter/material.dart';

import '../../model/operario_model.dart';

class ResultadoPantalla extends StatelessWidget {
  const ResultadoPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final operario =
        ModalRoute.of(context)!.settings.arguments as OperarioModel;
    Widget dato(String titulo, String valor) {
      return ListTile(title: Text(titulo), trailing: Text(valor));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  dato('Tipo de Operario', operario.tipo),
                  dato('Sueldo', '\$${operario.sueldo.toStringAsFixed(2)}'),
                  dato('Antigüedad', '${operario.antiguedad}'),
                  dato(
                    'Porcentaje de Aumento',
                    '${(operario.porcentaje * 100).toStringAsFixed(0)} %',
                  ),
                  dato(
                    'Monto de Aumento',
                    '\$${operario.aumento.toStringAsFixed(2)}',
                  ),
                  dato(
                    'Sueldo Final',
                    '\$${operario.sueldoFinal.toStringAsFixed(2)}',
                  ),
                ],
              ),
            ),
            //boton para regresar
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Regresar'),
            ),
          ],
        ),
      ),
    );
  }
}
