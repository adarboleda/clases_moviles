import 'package:flutter/material.dart';

import '../../model/consumo_model.dart';

class ResultadoPantalla extends StatelessWidget {
  const ResultadoPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    //recibir los parametros enviados desde la pantalla principal
    final consumo = ModalRoute.of(context)!.settings.arguments as ConsumoModel;
    final esquema = Theme.of(context).colorScheme;

    Widget dato(String titulo, String valor, {bool resaltado = false}) {
      return ListTile(
        dense: true,
        title: Text(titulo),
        trailing: Text(
          valor,
          style: TextStyle(
            fontWeight: resaltado ? FontWeight.bold : FontWeight.normal,
            fontSize: 15,
          ),
        ),
      );
    }

    final colorFondo = consumo.tieneExceso
        ? esquema.errorContainer
        : esquema.primaryContainer;
    final colorTexto = consumo.tieneExceso
        ? esquema.onErrorContainer
        : esquema.onPrimaryContainer;

    return Scaffold(
      appBar: AppBar(title: const Text('Resultado')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //resumen del valor adicional
            Card(
              color: colorFondo,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(
                      consumo.tieneExceso
                          ? Icons.warning_amber_rounded
                          : Icons.check_circle,
                      size: 48,
                      color: colorTexto,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Valor adicional a pagar',
                      style: TextStyle(color: colorTexto),
                    ),
                    Text(
                      '\$${consumo.totalAdicional.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorTexto,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      consumo.tieneExceso
                          ? 'Excediste tu plan este mes'
                          : 'Te mantuviste dentro de tu plan',
                      style: TextStyle(color: colorTexto),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  const ListTile(
                    leading: Icon(Icons.call),
                    title: Text(
                      'Minutos',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  dato('Consumidos', '${consumo.minutos} min'),
                  dato('Incluidos', '${ConsumoModel.minutosPlan} min'),
                  dato('Exceso', '${consumo.minutosExceso} min'),
                  dato(
                    'Costo exceso',
                    '\$${consumo.costoMinutos.toStringAsFixed(2)}',
                    resaltado: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  const ListTile(
                    leading: Icon(Icons.wifi),
                    title: Text(
                      'Datos',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  dato('Consumidos', '${consumo.gigas.toStringAsFixed(2)} GB'),
                  dato(
                    'Incluidos',
                    '${ConsumoModel.gigasPlan.toStringAsFixed(0)} GB',
                  ),
                  dato('Exceso', '${consumo.gigasExceso.toStringAsFixed(2)} GB'),
                  dato(
                    'Costo exceso',
                    '\$${consumo.costoGigas.toStringAsFixed(2)}',
                    resaltado: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            //botones para regresar
            FilledButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.edit),
              label: const Text('Modificar consumo'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () =>
                  Navigator.popUntil(context, ModalRoute.withName('/')),
              icon: const Icon(Icons.home),
              label: const Text('Volver al inicio'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
