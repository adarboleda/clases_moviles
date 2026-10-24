import 'package:flutter/material.dart';

import '../../modelo/tarifa_modelo.dart';
import '../../modelo/tipo_consumidor.dart';
import '../moleculas/fila_detalle.dart';
import '../utilidades/formato.dart';

class TarjetaTarifas extends StatelessWidget {
  final List<TarifaModelo> tarifas;

  const TarjetaTarifas({super.key, required this.tarifas});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        leading: Icon(
          Icons.receipt_long_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          'Tarifas vigentes',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        shape: const Border(),
        collapsedShape: const Border(),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          for (final tarifa in tarifas)
            FilaDetalle(
              etiqueta: '${tarifa.nombre} (${tarifa.rango})',
              valor: '${formatoMoneda(tarifa.precioM3)} / m³',
            ),
          const Divider(),
          for (final tipo in TipoConsumidor.values)
            FilaDetalle(
              etiqueta: '${tipo.nombre}: cargo fijo / recargo',
              valor:
                  '${formatoMoneda(tipo.cargoFijo)} / '
                  '${formatoPorcentaje(tipo.porcentajeRecargo)}',
            ),
        ],
      ),
    );
  }
}
