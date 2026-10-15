import 'package:flutter/material.dart';

import '../logica/calculadora_logica.dart';

class CalculadoraPantalla extends StatefulWidget {
  const CalculadoraPantalla({super.key, required this.title});
  final String title;
  @override
  State<CalculadoraPantalla> createState() => _CalculadoraPantallaState();
}

class _CalculadoraPantallaState extends State<CalculadoraPantalla> {
  Calculadora calculadora = Calculadora();
  final numero1Controller = TextEditingController();
  final numero2Controller = TextEditingController();
  String resultado = '0';

  void sumar() {
    double numero1 = double.tryParse(numero1Controller.text) ?? 0.0;
    double numero2 = double.tryParse(numero2Controller.text) ?? 0.0;

    setState(() {
      resultado = calculadora.sumar(numero1, numero2).toString();
    });
  }

  void restar() {
    double numero1 = double.tryParse(numero1Controller.text) ?? 0.0;
    double numero2 = double.tryParse(numero2Controller.text) ?? 0.0;

    setState(() {
      resultado = calculadora.restar(numero1, numero2).toString();
    });
  }

  void multiplicar() {
    double numero1 = double.tryParse(numero1Controller.text) ?? 0.0;
    double numero2 = double.tryParse(numero2Controller.text) ?? 0.0;

    setState(() {
      resultado = calculadora.multiplicar(numero1, numero2).toString();
    });
  }

  void dividir() {
    double numero1 = double.tryParse(numero1Controller.text) ?? 0.0;
    double numero2 = double.tryParse(numero2Controller.text) ?? 0.0;

    setState(() {
      if (numero2 == 0) {
        resultado = 'Error: División por cero';
      } else {
        resultado = calculadora.dividir(numero1, numero2).toString();
      }
    });
  }

  void limpiar() {
    numero1Controller.clear();
    numero2Controller.clear();
    setState(() {
      resultado = '0';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculadora'), backgroundColor: Colors.blue),
      body: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: numero1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Número 1'),
            ),
            SizedBox(height: 10.0),

            TextField(
              controller: numero2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Número 2'),
            ),
            SizedBox(height: 10.0),

            Wrap(
              spacing: 10.0,
              children: [
                ElevatedButton(onPressed: sumar, child: const Text('+')),
                ElevatedButton(onPressed: restar, child: const Text('-')),
                ElevatedButton(onPressed: multiplicar, child: const Text('×')),
                ElevatedButton(onPressed: dividir, child: const Text('÷')),
              ],
            ),

            Text(
              'Resultado: $resultado',
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      //boton limpiar
      floatingActionButton: FloatingActionButton(
        onPressed: limpiar,
        tooltip: 'Limpiar',
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: const Icon(Icons.clear),
      ),
    );
  }
}
