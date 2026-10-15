import 'package:flutter/material.dart';

import '../logica/viaje.dart';

//declarar stateful widget
class ViajePantalla extends StatefulWidget {
  @override
  State<ViajePantalla> createState() => _ViajePantallaState();
}

class _ViajePantallaState extends State<ViajePantalla> {
  //mapeo
  final viaje = Viaje();
  final alumnosController = TextEditingController();

  //logica

  String costoTotal = '0.00';
  String pagoTotal = '0.00';
  String mensaje = '0.00';

  void calcular() {
    int? alumnos = int.tryParse(alumnosController.text);
    if (alumnos == null || alumnos <= 0) {
      setState(() {
        mensaje = 'Ingrese un número válido de alumnos.';
        costoTotal = '0.00';
        pagoTotal = '0.00';
      });
      return;
    }
    //visualizar
    double costo = viaje.calcularCostoAlumno(alumnos);
    double total = viaje.calcularPagoTotal(alumnos);

    setState(() {
      costoTotal = costo.toStringAsFixed(2);
      pagoTotal = total.toStringAsFixed(2);
      mensaje = '';
    });
  }

  //metodo limpiar
  void limpiar() {
    setState(() {
      alumnosController.clear();
      costoTotal = '0.00';
      pagoTotal = '0.00';
      mensaje = '';
    });
  }

  //diseno
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Viaje Estudiantil'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Calcular viaje', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            TextField(
              controller: alumnosController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Número de alumnos',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: calcular, child: Text('Calcular')),
            SizedBox(height: 20),
            Text(mensaje, style: TextStyle(color: Colors.red)),
            SizedBox(height: 10),
            Text(
              'Costo por alumno: \$${costoTotal}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Pago a la compañia: \$${pagoTotal}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: limpiar,
        tooltip: 'Limpiar',
        child: Icon(Icons.clear),
      ),
    );
  }
}
