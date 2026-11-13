import 'package:flutter/material.dart';

import '../utils/formato.dart';

class CampoFecha extends StatelessWidget {
  final String etiqueta;
  final DateTime fecha;
  final IconData icono;
  final VoidCallback onTap;
  final String? error;

  const CampoFecha({
    super.key,
    required this.etiqueta,
    required this.fecha,
    required this.icono,
    required this.onTap,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: etiqueta,
          prefixIcon: Icon(icono),
          suffixIcon: const Icon(Icons.edit_calendar_outlined),
          errorText: error,
        ),
        child: Text(
          formatoFecha(fecha),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
