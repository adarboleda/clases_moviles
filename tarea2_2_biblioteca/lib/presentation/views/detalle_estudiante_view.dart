import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/estudiante.dart';
import '../../domain/reglas/reglas_prestamo.dart';
import '../../routes/app_routes.dart';
import '../theme/app_tema.dart';
import '../viewmodels/prestamo_viewmodel.dart';
import '../widgets/avatar_estudiante.dart';
import '../widgets/aviso.dart';
import '../widgets/tarjeta_prestamo.dart';

class DetalleEstudianteView extends StatelessWidget {
  const DetalleEstudianteView({super.key});

  @override
  Widget build(BuildContext context) {
    final estudiante = ModalRoute.of(context)!.settings.arguments as Estudiante;
    final vm = context.watch<PrestamoViewModel>();
    final lista = vm.prestamosDe(estudiante.id!);
    final activos = lista.where((p) => p.activo).length;
    final vencidos = lista.where((p) => p.estaVencido(vm.hoy)).length;
    final devueltos = lista.length - activos;
    final bloqueo = vm.motivoBloqueo(estudiante.id!);
    final textos = Theme.of(context).textTheme;

    Widget dato(IconData icono, String texto) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icono, size: 16, color: Colors.white70),
        const SizedBox(width: 6),
        Flexible(
          child: Text(texto, style: const TextStyle(color: Colors.white)),
        ),
      ],
    );

    Widget contador(String titulo, String valor, Color color) => Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            children: [
              Text(
                valor,
                style: TextStyle(
                  color: color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(titulo, style: textos.bodyMedium),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Estudiante')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColores.verde,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                AvatarEstudiante(estudiante: estudiante, radio: 34),
                const SizedBox(height: 12),
                Text(
                  estudiante.nombre,
                  textAlign: TextAlign.center,
                  style: textos.titleLarge?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  estudiante.carrera,
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 14),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16,
                  runSpacing: 6,
                  children: [
                    dato(Icons.badge_outlined, estudiante.cedula),
                    dato(Icons.email_outlined, estudiante.correo),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              contador(
                'Activos',
                '$activos/${ReglasPrestamo.maximoActivos}',
                AppColores.verde,
              ),
              const SizedBox(width: 10),
              contador('Vencidos', '$vencidos', AppColores.rojo),
              const SizedBox(width: 10),
              contador('Devueltos', '$devueltos', AppColores.textoSuave),
            ],
          ),
          const SizedBox(height: 16),
          Aviso(
            tipo: bloqueo == null ? TipoAviso.exito : TipoAviso.error,
            mensaje: bloqueo ?? 'Puede solicitar préstamos',
          ),
          const SizedBox(height: 24),
          Text('Historial de préstamos', style: textos.titleMedium),
          const SizedBox(height: 12),
          if (lista.isEmpty)
            Text(
              'Este estudiante aún no tiene préstamos',
              style: textos.bodyMedium,
            ),
          for (final prestamo in lista)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TarjetaPrestamo(
                prestamo: prestamo,
                estado: vm.estadoDe(prestamo),
                hoy: vm.hoy,
                mostrarEstudiante: false,
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.detallePrestamo,
                  arguments: prestamo,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
