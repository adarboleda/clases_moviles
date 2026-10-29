import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/consumo_model.dart';
import '../../view_model/consumo_viewmodel.dart';
import '../widgets/barra_consumo.dart';
import '../widgets/campo_numero.dart';

class PrincipalPantalla extends StatefulWidget {
  const PrincipalPantalla({super.key});

  @override
  State<PrincipalPantalla> createState() => _PrincipalPantallaState();
}

class _PrincipalPantallaState extends State<PrincipalPantalla> {
  final minutosController = TextEditingController();
  final gigasController = TextEditingController();

  void calcular() {
    FocusScope.of(context).unfocus();

    //recibir el view model sin escuchar cambios
    final vm = context.read<ConsumoViewModel>();
    if (!vm.esValido) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Corrige los valores ingresados')),
      );
      return;
    }
    final resultado = vm.calcular();

    //paso de parametros a la pantalla de resultados
    Navigator.pushNamed(context, '/resultado', arguments: resultado);
  }

  void limpiar() {
    minutosController.clear();
    gigasController.clear();
    context.read<ConsumoViewModel>().limpiar();
  }

  @override
  void dispose() {
    minutosController.dispose();
    gigasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //escuchar cambios del view model para redibujar
    final vm = context.watch<ConsumoViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumo del mes'),
        actions: [
          IconButton(
            tooltip: 'Limpiar',
            onPressed: limpiar,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Ingresa lo que consumiste este mes',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            CampoNumero(
              etiqueta: 'Minutos consumidos',
              sufijo: 'min',
              icono: Icons.call,
              controller: minutosController,
              onChanged: vm.actualizarMinutos,
              error: vm.errorMinutos,
            ),
            const SizedBox(height: 16),
            CampoNumero(
              etiqueta: 'Gigabytes consumidos',
              sufijo: 'GB',
              icono: Icons.wifi,
              controller: gigasController,
              onChanged: vm.actualizarGigas,
              error: vm.errorGigas,
              decimal: true,
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    BarraConsumo(
                      titulo: 'Minutos',
                      detalle: '${vm.minutos} / ${ConsumoModel.minutosPlan}',
                      progreso: vm.usoMinutos,
                      excedido: vm.excedeMinutos,
                    ),
                    const SizedBox(height: 20),
                    BarraConsumo(
                      titulo: 'Datos',
                      detalle:
                          '${vm.gigas.toStringAsFixed(1)} / ${ConsumoModel.gigasPlan.toStringAsFixed(0)} GB',
                      progreso: vm.usoGigas,
                      excedido: vm.excedeGigas,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: calcular,
              label: const Text('Calcular'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
