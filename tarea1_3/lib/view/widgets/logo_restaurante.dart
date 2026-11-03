import 'package:flutter/material.dart';

class LogoRestaurante extends StatelessWidget {
  final double tamanio;

  const LogoRestaurante({super.key, this.tamanio = 140});

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;

    return Container(
      width: tamanio,
      height: tamanio,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(
        Icons.restaurant_menu,
        size: tamanio * 0.5,
        color: esquema.primary,
      ),
    );
  }
}
