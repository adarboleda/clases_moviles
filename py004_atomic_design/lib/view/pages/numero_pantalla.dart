import 'package:flutter/material.dart';

import '../../controller/numeros_controladores.dart';
import '../../model/numeros_modelos.dart';
import '../organisms/formulario_numero.dart';

class NumerosPantalla extends StatefulWidget {
  const NumerosPantalla({super.key});

  @override
  State<NumerosPantalla> createState() => _NumerosPantallaState();
}

class _NumerosPantallaState extends State<NumerosPantalla> {
  //mapeo de objetos
  final a = TextEditingController();
  final b = TextEditingController();
  final c = TextEditingController();
  //instanciacion de clases
  final controladores = NumerosControladores();
  //variable para almacenar resultados
  NumerosModelos? resultado;
  //metodo calcular
  void calcular() {
    int? n1 = int.tryParse(a.text);
    int? n2 = int.tryParse(b.text);
    int? n3 = int.tryParse(c.text);
    if (n1 == null || n2 == null || n3 == null) {
      setState(() {
        resultado = null; // Reiniciar el resultado si hay un error
      });
      return;
    }
    setState(() {
      resultado = controladores.calcular(n1, n2, n3);
    });
  }

  //limpiar
  void limpiar() {
    setState(() {
      a.clear();
      b.clear();
      c.clear();
      resultado = null;
    });
  }

  /*diseño de la pantalla principal*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ejercicio de Numeros',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      //boton limpiar
      floatingActionButton: FloatingActionButton(
        onPressed: limpiar,
        tooltip: 'Limpiar',
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.clear),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Ingrese 3 valores:'),
              SizedBox(height: 15),
              //boton calcular
              //fomrulario
              FormularioNumeros(a: a, b: b, c: c),
              SizedBox(height: 15),
              //boton flotante para limpiar
              ElevatedButton(onPressed: calcular, child: Text('Calcular')),

              SizedBox(height: 15),
              //mostrar resultados
              if (resultado != null) ...[
                Card(
                  color: Colors.blue[100],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Resultados:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('Suma: ${resultado!.suma}'),
                        Text(
                          'Promedio: ${resultado!.promedio.toStringAsFixed(2)}',
                        ),
                        Text('Producto: ${resultado!.producto}'),
                        Text('Números diferentes: ${resultado!.diferentes}'),
                        if (resultado!.divisible.isNotEmpty)
                          Text(resultado!.divisible),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
