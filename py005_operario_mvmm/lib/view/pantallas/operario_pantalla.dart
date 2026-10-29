import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/operario_viewmodel.dart';
import '../widgets/campo_numero.dart';
import '../widgets/option_button.dart';

class OperarioPantalla extends StatefulWidget {
  //mapeo y la logica
  const OperarioPantalla({super.key});

  @override
  State<OperarioPantalla> createState() => _OperarioPantallaState();
}

class _OperarioPantallaState extends State<OperarioPantalla> {
  //mapeo
  final sueldoController = TextEditingController();
  final antiguedadController = TextEditingController();

  //paso de parametros
  //rutas
  void calcular() {
    double sueldo = double.tryParse(sueldoController.text) ?? 0.0;
    int antiguedad = int.tryParse(antiguedadController.text) ?? 0;

    //recibir a view model
    final vm = context.read<OperarioViewModel>();
    final resultado = vm.calcular(sueldo, antiguedad);

    //pase de parametros
    Navigator.pushNamed(context, '/resultado', arguments: resultado);
  }

  @override
  void dispose() {
    sueldoController.dispose();
    antiguedadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //decalarar view model
    final vm = context.watch<OperarioViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('sueldo del operador'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            CampoNumero(etiqueta: 'Sueldo', controller: sueldoController),
            const SizedBox(height: 10.0),
            CampoNumero(
              etiqueta: 'Antigüedad',
              controller: antiguedadController,
            ),
            const SizedBox(height: 10.0),
            //el RadioGroup maneja la opcion seleccionada
            RadioGroup<String>(
              groupValue: vm.tipoOperario,
              onChanged: (value) {
                if (value != null) {
                  vm.seleccionarTipo(value);
                }
              },
              child: const Column(
                children: [
                  OptionButton(titulo: 'Operativo', valor: 'Operativo'),
                  OptionButton(
                    titulo: 'Administrativo',
                    valor: 'Administrativo',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(onPressed: calcular, child: const Text('Calcular')),
          ],
        ),
      ),
    );
  }
}
