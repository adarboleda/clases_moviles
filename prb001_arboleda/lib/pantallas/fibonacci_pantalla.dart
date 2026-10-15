import 'package:flutter/material.dart';

import '../logica/fibonacci_logica.dart';

class FibonacciPantalla extends StatefulWidget {
  const FibonacciPantalla({super.key});

  @override
  State<FibonacciPantalla> createState() => _FibonacciPantallaState();
}

class _FibonacciPantallaState extends State<FibonacciPantalla> {
  Fibonacci fibonacci = Fibonacci();
  final cantidadController = TextEditingController();
  String serie = '';
  String mensaje = '';

  @override
  void dispose() {
    cantidadController.dispose();
    super.dispose();
  }

  void generar() {
    int n = int.tryParse(cantidadController.text) ?? 0;

    setState(() {
      if (n <= 0) {
        serie = '';
        mensaje = 'Ingrese un número entero positivo';
      } else if (n > 50) {
        serie = '';
        mensaje = 'Ingrese un número máximo de 50';
      } else {
        serie = fibonacci.generar(n).join(', ');
        mensaje = 'Primeros $n términos:';
      }
    });
  }

  void limpiar() {
    cantidadController.clear();
    setState(() {
      serie = '';
      mensaje = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Serie de Fibonacci'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Ingrese la cantidad de términos (N)',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: cantidadController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'N',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(onPressed: generar, child: Text('Generar')),
            SizedBox(height: 10.0),
            Text(mensaje, style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 10.0),
            //la serie puede ser larga, por eso se puede desplazar
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  serie,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22.0, color: Colors.green),
                ),
              ),
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
