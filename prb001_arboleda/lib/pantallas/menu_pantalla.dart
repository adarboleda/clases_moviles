import 'package:flutter/material.dart';

class MenuPantalla extends StatelessWidget {
  const MenuPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ejercicios - Grupo 1'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Seleccione un ejercicio',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            //opcion ejercicio 4
            Card(
              child: ListTile(
                leading: Icon(Icons.check_circle, color: Colors.blue),
                title: Text('Ejercicio 4. Números perfectos'),
                subtitle: Text('Suma de divisores propios igual al número'),
                onTap: () => Navigator.pushNamed(context, '/perfecto'),
              ),
            ),
            //opcion ejercicio 5
            Card(
              child: ListTile(
                leading: Icon(Icons.format_list_numbered, color: Colors.blue),
                title: Text('Ejercicio 5. Serie de Fibonacci'),
                subtitle: Text('Generar los primeros N términos'),
                onTap: () => Navigator.pushNamed(context, '/fibonacci'),
              ),
            ),
            //opcion ejercicio 6
            Card(
              child: ListTile(
                leading: Icon(Icons.calculate, color: Colors.blue),
                title: Text('Ejercicio 6. Número Armstrong'),
                subtitle: Text(
                  'Suma de dígitos elevados a la cantidad de cifras',
                ),
                onTap: () => Navigator.pushNamed(context, '/armstrong'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
