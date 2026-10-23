import 'package:flutter/material.dart';

class ResultadoEdad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final argumentos =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int anios = argumentos['anios'];
    int meses = argumentos['meses'];
    int dias = argumentos['dias'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado de Edad'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Edad de la persona'),
            SizedBox(height: 10.0),
            Text('Años: $anios'),
            SizedBox(height: 10.0),
            Text('Meses: $meses'),
            SizedBox(height: 10.0),
            Text('Días: $dias'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}
