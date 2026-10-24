import 'package:flutter/material.dart';

import '../../modelo/pago_modelo.dart';
import '../atomos/boton_principal.dart';
import '../atomos/boton_secundario.dart';
import '../moleculas/resumen_total.dart';
import '../organismos/tarjeta_detalle_pago.dart';
import '../tema/tema_app.dart';
import '../utilidades/formato.dart';

class DetallePagoPantalla extends StatelessWidget {
  const DetallePagoPantalla({super.key});

  void confirmarPago(BuildContext context, PagoModelo pago) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: AppColores.exito, size: 56),
        title: const Text('Pago registrado'),
        content: Text(
          'Se registró el pago de ${formatoMoneda(pago.total)} '
          'para la cuenta ${pago.datos.numeroCuenta}.',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pop(context, true);
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pago = ModalRoute.of(context)!.settings.arguments as PagoModelo;

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de pago')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ResumenTotal(total: pago.total, consumo: pago.consumo),
                  const SizedBox(height: 16.0),
                  TarjetaDetallePago(pago: pago),
                  const SizedBox(height: 24.0),
                  BotonPrincipal(
                    texto: 'Confirmar pago',
                    icono: Icons.payments_outlined,
                    onPressed: () => confirmarPago(context, pago),
                  ),
                  const SizedBox(height: 12.0),
                  BotonSecundario(
                    texto: 'Corregir datos',
                    icono: Icons.edit_outlined,
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
