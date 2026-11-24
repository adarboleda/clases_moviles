import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/app_theme.dart';
import '../utils/formato.dart';
import '../viewmodels/reserva_viewmodel.dart';

/// Muestra la última reserva recuperada desde SharedPreferences.
class BoletosView extends StatelessWidget {
  const BoletosView({super.key});

  @override
  Widget build(BuildContext context) {
    final reserva = context.watch<ReservaViewModel>().ultimaReserva;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Mis boletos',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 20),
        if (reserva == null)
          const Padding(
            padding: EdgeInsets.only(top: 80),
            child: Column(
              children: [
                Icon(
                  Icons.confirmation_number_outlined,
                  size: 72,
                  color: AppColors.textoSecundario,
                ),
                SizedBox(height: 12),
                Text(
                  'Aún no tienes reservas.\nElige una película en Inicio.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textoSecundario),
                ),
              ],
            ),
          )
        else
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.tarjeta,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.acento.withValues(alpha: 0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ÚLTIMA RESERVA',
                  style: TextStyle(
                    color: AppColors.textoSecundario,
                    letterSpacing: 1.2,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  reserva.pelicula,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${formatearFecha(reserva.fecha)} · ${reserva.hora}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColors.acento,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
