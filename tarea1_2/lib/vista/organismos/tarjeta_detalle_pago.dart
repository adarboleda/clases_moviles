import 'package:flutter/material.dart';

import '../../modelo/pago_modelo.dart';
import '../atomos/texto_seccion.dart';
import '../moleculas/fila_detalle.dart';
import '../utilidades/formato.dart';

class TarjetaDetallePago extends StatelessWidget {
  final PagoModelo pago;

  const TarjetaDetallePago({super.key, required this.pago});

  @override
  Widget build(BuildContext context) {
    final datos = pago.datos;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TextoSeccion(texto: 'Datos del cliente'),
            FilaDetalle(
              etiqueta: 'Número de cuenta',
              valor: datos.numeroCuenta,
            ),
            FilaDetalle(etiqueta: 'Cliente', valor: datos.nombreCliente),
            FilaDetalle(
              etiqueta: 'Tipo de consumidor',
              valor: datos.tipo.nombre,
            ),
            const Divider(),

            const TextoSeccion(texto: 'Consumo'),
            FilaDetalle(
              etiqueta: 'Lectura anterior',
              valor: '${datos.lecturaAnterior} m³',
            ),
            FilaDetalle(
              etiqueta: 'Lectura actual',
              valor: '${datos.lecturaActual} m³',
            ),
            FilaDetalle(etiqueta: 'Consumo', valor: '${pago.consumo} m³'),
            FilaDetalle(
              etiqueta: 'Rango aplicado',
              valor: '${pago.tarifa.nombre} (${pago.tarifa.rango})',
            ),
            FilaDetalle(
              etiqueta: 'Tarifa por m³',
              valor: formatoMoneda(pago.tarifa.precioM3),
            ),
            const Divider(),

            const TextoSeccion(texto: 'Cargos aplicados'),
            FilaDetalle(
              etiqueta:
                  'Valor consumo (${pago.consumo} m³ × '
                  '${formatoMoneda(pago.tarifa.precioM3)})',
              valor: formatoMoneda(pago.valorConsumo),
            ),
            FilaDetalle(
              etiqueta: 'Cargo fijo',
              valor: formatoMoneda(pago.cargoFijo),
            ),
            FilaDetalle(
              etiqueta: 'Subtotal',
              valor: formatoMoneda(pago.subtotal),
            ),
            FilaDetalle(
              etiqueta:
                  'Recargo (${formatoPorcentaje(pago.porcentajeRecargo)})',
              valor: formatoMoneda(pago.recargo),
            ),
            const Divider(),

            FilaDetalle(
              etiqueta: 'Total a pagar',
              valor: formatoMoneda(pago.total),
              resaltado: true,
            ),
          ],
        ),
      ),
    );
  }
}
