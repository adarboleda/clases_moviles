import 'package:flutter/material.dart';

import '../../model/consumo_model.dart';

class InicioPantalla extends StatelessWidget {
  const InicioPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;

    Widget beneficio(IconData icono, String titulo, String valor) {
      return ListTile(
        leading: CircleAvatar(
          backgroundColor: esquema.primaryContainer,
          child: Icon(icono, color: esquema.onPrimaryContainer),
        ),
        title: Text(titulo),
        trailing: Text(
          valor,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              const SizedBox(height: 16),
              Text(
                'Control de Consumo',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Revisa cuánto pagarás de más por exceder tu plan este mes.',
                textAlign: TextAlign.center,
                style: TextStyle(color: esquema.onSurfaceVariant),
              ),
              const SizedBox(height: 32),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      const ListTile(
                        title: Text(
                          'Tu plan incluye',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      beneficio(
                        Icons.call,
                        'Minutos',
                        '${ConsumoModel.minutosPlan} min',
                      ),
                      beneficio(
                        Icons.wifi,
                        'Navegación',
                        '${ConsumoModel.gigasPlan.toStringAsFixed(0)} GB',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                color: esquema.secondaryContainer,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      const ListTile(
                        title: Text(
                          'Costo por exceso',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      beneficio(
                        Icons.timer,
                        'Minuto adicional',
                        '\$${ConsumoModel.costoMinutoExtra.toStringAsFixed(2)}',
                      ),
                      beneficio(
                        Icons.data_usage,
                        'GB adicional',
                        '\$${ConsumoModel.costoGigaExtra.toStringAsFixed(2)}',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/principal'),
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Comenzar'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
