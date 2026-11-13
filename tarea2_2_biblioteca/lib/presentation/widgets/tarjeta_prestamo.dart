import 'package:flutter/material.dart';

import '../../domain/entities/prestamo.dart';
import '../theme/app_tema.dart';
import '../utils/formato.dart';
import '../viewmodels/prestamo_viewmodel.dart';
import 'anillo_dias.dart';
import 'chip_estado.dart';
import 'portada_libro.dart';

class TarjetaPrestamo extends StatelessWidget {
  final Prestamo prestamo;
  final EstadoVisible estado;
  final DateTime hoy;
  final VoidCallback? onTap;
  final bool mostrarEstudiante;

  const TarjetaPrestamo({
    super.key,
    required this.prestamo,
    required this.estado,
    required this.hoy,
    this.onTap,
    this.mostrarEstudiante = true,
  });

  @override
  Widget build(BuildContext context) {
    final textos = Theme.of(context).textTheme;

    final String fecha;
    switch (estado) {
      case EstadoVisible.activo:
        fecha = 'Devolver hasta ${formatoFecha(prestamo.fechaDevolucion)}';
      case EstadoVisible.vencido:
        fecha = 'Venció el ${formatoFecha(prestamo.fechaDevolucion)}';
      case EstadoVisible.devuelto:
        fecha =
            'Devuelto el ${formatoFecha(prestamo.fechaEntrega ?? prestamo.fechaDevolucion)}';
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              PortadaLibro(
                url: prestamo.libroPortadaUrl,
                titulo: prestamo.libroTitulo,
                ancho: 50,
                alto: 72,
                radio: 8,
                sombra: false,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      prestamo.libroTitulo,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textos.titleMedium?.copyWith(fontSize: 15),
                    ),
                    if (mostrarEstudiante) ...[
                      const SizedBox(height: 2),
                      Text(prestamo.estudianteNombre, style: textos.bodyMedium),
                    ],
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.event,
                          size: 14,
                          color: ChipEstado.colorDe(estado),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            fecha,
                            style: TextStyle(
                              fontSize: 12,
                              color: estado == EstadoVisible.vencido
                                  ? AppColores.rojo
                                  : AppColores.textoSuave,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (estado == EstadoVisible.devuelto)
                ChipEstado(estado: estado)
              else
                AnilloDias(prestamo: prestamo, hoy: hoy),
            ],
          ),
        ),
      ),
    );
  }
}
