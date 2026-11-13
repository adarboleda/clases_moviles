import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/reglas/reglas_prestamo.dart';
import '../../routes/app_routes.dart';
import '../theme/app_tema.dart';
import '../utils/recargar.dart';
import '../viewmodels/estudiante_viewmodel.dart';
import '../viewmodels/prestamo_viewmodel.dart';
import '../widgets/avatar_estudiante.dart';
import '../widgets/vista_estado.dart';

class EstudiantesView extends StatelessWidget {
  const EstudiantesView({super.key});

  Future<void> registrar(BuildContext context) async {
    final registrado = await Navigator.pushNamed(
      context,
      AppRoutes.nuevoEstudiante,
    );
    if (registrado == true && context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Estudiante registrado')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<EstudianteViewModel>();
    final prestamos = context.watch<PrestamoViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Estudiantes',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Text(
                    '${vm.estudiantes.length} registrados',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => recargarTodo(context),
                child: VistaEstado(
                  cargando: vm.cargando,
                  error: vm.error,
                  vacio: vm.estudiantes.isEmpty,
                  mensajeVacio: 'Aún no hay estudiantes registrados',
                  onReintentar: () => recargarTodo(context),
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 96),
                    itemCount: vm.estudiantes.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (context, indice) {
                      final estudiante = vm.estudiantes[indice];
                      final activos = prestamos.activosDe(estudiante.id!);
                      final bloqueado =
                          prestamos.motivoBloqueo(estudiante.id!) != null;
                      final color = bloqueado
                          ? AppColores.rojo
                          : AppColores.verde;

                      return Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          leading: AvatarEstudiante(estudiante: estudiante),
                          title: Text(
                            estudiante.nombre,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            '${estudiante.carrera}\nCI ${estudiante.cedula}',
                          ),
                          isThreeLine: true,
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$activos/${ReglasPrestamo.maximoActivos}',
                                style: TextStyle(
                                  color: color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                bloqueado ? 'Bloqueado' : 'Activos',
                                style: TextStyle(color: color, fontSize: 11),
                              ),
                            ],
                          ),
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.detalleEstudiante,
                            arguments: estudiante,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => registrar(context),
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Registrar'),
      ),
    );
  }
}
