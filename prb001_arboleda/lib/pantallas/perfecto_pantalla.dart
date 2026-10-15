import 'package:flutter/material.dart';

import '../logica/perfecto_logica.dart';

class PerfectoPantalla extends StatefulWidget {
  const PerfectoPantalla({super.key});

  @override
  State<PerfectoPantalla> createState() => _PerfectoPantallaState();
}

class _PerfectoPantallaState extends State<PerfectoPantalla> {
  NumeroPerfecto perfecto = NumeroPerfecto();
  final numeroController = TextEditingController();
  String divisores = '';
  String suma = '';
  String resultado = '';
  Color colorResultado = Colors.black;

  @override
  void dispose() {
    numeroController.dispose();
    super.dispose();
  }

  void verificar() {
    int numero = int.tryParse(numeroController.text) ?? 0;

    setState(() {
      if (numero <= 0) {
        divisores = '';
        suma = '';
        resultado = 'Ingrese un número entero positivo';
        colorResultado = Colors.red;
      } else {
        divisores = perfecto.divisores(numero).join(' + ');
        suma = perfecto.sumaDivisores(numero).toString();
        if (perfecto.esPerfecto(numero)) {
          resultado = '$numero SÍ es un número perfecto';
          colorResultado = Colors.green;
        } else {
          resultado = '$numero NO es un número perfecto';
          colorResultado = Colors.red;
        }
      }
    });
  }

  void limpiar() {
    numeroController.clear();
    setState(() {
      divisores = '';
      suma = '';
      resultado = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Números Perfectos'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Ingrese un número entero positivo',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: numeroController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Número',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(onPressed: verificar, child: Text('Verificar')),
            SizedBox(height: 10.0),
            Text('Divisores: $divisores', style: TextStyle(fontSize: 18.0)),
            Text('Suma: $suma', style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 10.0),
            Text(
              resultado,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, color: colorResultado),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: limpiar,
        tooltip: 'Limpiar',
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.clear),
      ),
    );
  }
}
