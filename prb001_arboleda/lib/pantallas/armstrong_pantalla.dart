import 'package:flutter/material.dart';

import '../logica/armstrong_logica.dart';

class ArmstrongPantalla extends StatefulWidget {
  const ArmstrongPantalla({super.key});

  @override
  State<ArmstrongPantalla> createState() => _ArmstrongPantallaState();
}

class _ArmstrongPantallaState extends State<ArmstrongPantalla> {
  NumeroArmstrong armstrong = NumeroArmstrong();
  final numeroController = TextEditingController();
  String cifras = '';
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
        cifras = '';
        suma = '';
        resultado = 'Ingrese un número entero positivo';
        colorResultado = Colors.red;
      } else {
        cifras = armstrong.cantidadCifras(numero).toString();
        suma = armstrong.sumaPotencias(numero).toString();
        if (armstrong.esArmstrong(numero)) {
          resultado = '$numero SÍ es un número Armstrong';
          colorResultado = Colors.green;
        } else {
          resultado = '$numero NO es un número Armstrong';
          colorResultado = Colors.red;
        }
      }
    });
  }

  void limpiar() {
    numeroController.clear();
    setState(() {
      cifras = '';
      suma = '';
      resultado = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Número Armstrong'),
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
            Text('Cantidad de cifras: $cifras', style: TextStyle(fontSize: 18.0)),
            Text('Suma de potencias: $suma', style: TextStyle(fontSize: 18.0)),
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
