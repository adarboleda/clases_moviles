import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AvisosView extends StatelessWidget {
  const AvisosView({super.key});

  static const _avisos = [
    ('Nueva cartelera', 'Reserva tus boletos para las películas de la semana.'),
    ('Martes de descuento', 'Boletos a mitad de precio todos los martes.'),
    ('Nueva sala premier', 'Disfruta de la mejor experiencia en sala premier.'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Avisos',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        for (final (titulo, detalle) in _avisos)
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppColors.tarjeta,
              borderRadius: BorderRadius.circular(14),
            ),
            child: ListTile(
              leading: const Icon(Icons.notifications, color: AppColors.acento),
              title: Text(titulo),
              subtitle: Text(detalle),
            ),
          ),
      ],
    );
  }
}
