import 'package:flutter/material.dart';

//definir clase pricipal
//1. declarar/crear|
class AreaPantalla extends StatefulWidget {
  const AreaPantalla({super.key, this.title = 'Area de un terreno'});

  final String title;

  @override
  State<AreaPantalla> createState() => _AreaPantallaState();
}

//2. implementar
class _AreaPantallaState extends State<AreaPantalla> {
  //mapeo de objeto
  final baseController = TextEditingController();
  final alturaController = TextEditingController();
  double area = 0.0, perimetro = 0.0, valor = 0.0;

  @override
  void dispose() {
    baseController.dispose();
    alturaController.dispose();
    super.dispose();
  }

  void calcular() {
    final base = double.tryParse(baseController.text) ?? 0.0;
    final altura = double.tryParse(alturaController.text) ?? 0.0;

    setState(() {
      area = base * altura;
      perimetro = 2 * (base + altura);
      valor = area * 150; //valor del terreno
    });
  }

  //diseño
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Area y Perimetro de un Terreno'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //etiqueta
            Text(
              'Ingrese la base y altura del terreno',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            //campo de texto
            TextField(
              controller: baseController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Base m2',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10.0),
            //campo de texto
            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Altura m2',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10.0),
            //boton
            ElevatedButton(onPressed: calcular, child: Text('Calcular')),
            SizedBox(height: 10.0),
            //resultado
            Text(
              'Area: ${area.toStringAsFixed(2)} m2',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'Perimetro: ${perimetro.toStringAsFixed(2)} m',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'Valor: ${valor.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 30.0, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
