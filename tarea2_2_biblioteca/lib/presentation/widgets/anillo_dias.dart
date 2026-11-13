import 'package:flutter/material.dart';

import '../../domain/entities/prestamo.dart';
import '../theme/app_tema.dart';

//anillo con los dias que faltan para devolver el libro
class AnilloDias extends StatelessWidget {
  final Prestamo prestamo;
  final DateTime hoy;
  final double tamanio;

  const AnilloDias({
    super.key,
    required this.prestamo,
    required this.hoy,
    this.tamanio = 48,
  });

  @override
  Widget build(BuildContext context) {
    final restantes = prestamo.diasRestantes(hoy);
    final duracion = prestamo.duracionDias < 1 ? 1 : prestamo.duracionDias;
    final vencido = restantes < 0;
    final color = vencido ? AppColores.rojo : AppColores.naranja;
    final progreso = vencido ? 1.0 : (restantes / duracion).clamp(0.0, 1.0);

    return Tooltip(
      message: vencido
          ? 'Vencido hace ${-restantes} días'
          : 'Faltan $restantes días',
      child: SizedBox(
        width: tamanio,
        height: tamanio,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox.expand(
              child: CircularProgressIndicator(
                value: progreso,
                strokeWidth: 4,
                color: color,
                backgroundColor: AppColores.gris,
              ),
            ),
            Text(
              vencido ? '!' : '${restantes}d',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
