import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/prestamo.dart';
import '../../domain/errores/biblioteca_exception.dart';
import '../theme/app_tema.dart';
import '../utils/formato.dart';
import '../viewmodels/libro_viewmodel.dart';
import '../viewmodels/prestamo_viewmodel.dart';
import '../widgets/aviso.dart';
import '../widgets/chip_estado.dart';
import '../widgets/portada_libro.dart';

class DetallePrestamoView extends StatefulWidget {
  const DetallePrestamoView({super.key});

  @override
  State<DetallePrestamoView> createState() => _DetallePrestamoViewState();
}

class _DetallePrestamoViewState extends State<DetallePrestamoView> {
  bool guardando = false;

  Future<void> registrarDevolucion(Prestamo prestamo) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Registrar devolución'),
        content: Text(
          '¿Confirmas que ${prestamo.estudianteNombre} devolvió '
          '"${prestamo.libroTitulo}"? El stock del libro aumentará en 1.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
    if (confirmado != true || !mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    final prestamos = context.read<PrestamoViewModel>();
    final libros = context.read<LibroViewModel>();
    setState(() => guardando = true);

    try {
      await prestamos.devolver(prestamo);
      //el stock del libro cambio en la API
      await libros.cargar();
      messenger.showSnackBar(
        const SnackBar(content: Text('Devolución registrada')),
      );
    } on BibliotecaException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.mensaje)));
    } finally {
      if (mounted) setState(() => guardando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final argumento = ModalRoute.of(context)!.settings.arguments as Prestamo;
    final vm = context.watch<PrestamoViewModel>();
    //se usa la version actual del prestamo para ver el cambio de estado
    final prestamo = vm.prestamoPorId(argumento.id!) ?? argumento;
    final estado = vm.estadoDe(prestamo);
    final restantes = prestamo.diasRestantes(vm.hoy);

    Widget fila(IconData icono, String etiqueta, String valor, {Color? color}) {
      return ListTile(
        leading: Icon(icono, color: AppColores.verde),
        title: Text(etiqueta, style: Theme.of(context).textTheme.bodyMedium),
        trailing: Text(
          valor,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: color ?? AppColores.texto,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del préstamo')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: PortadaLibro(
              url: prestamo.libroPortadaUrl,
              titulo: prestamo.libroTitulo,
              ancho: 130,
              alto: 190,
              radio: 12,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            prestamo.libroTitulo,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Center(child: ChipEstado(estado: estado)),
          const SizedBox(height: 20),
          Card(
            child: Column(
              children: [
                fila(
                  Icons.person_outline,
                  'Estudiante',
                  prestamo.estudianteNombre,
                ),
                fila(
                  Icons.event,
                  'Fecha de préstamo',
                  formatoFecha(prestamo.fechaPrestamo),
                ),
                fila(
                  Icons.event_available,
                  'Fecha de devolución',
                  formatoFecha(prestamo.fechaDevolucion),
                ),
                fila(
                  Icons.timelapse,
                  'Duración',
                  formatoDias(prestamo.duracionDias),
                ),
                if (estado == EstadoVisible.activo)
                  fila(
                    Icons.hourglass_bottom,
                    'Días restantes',
                    formatoDias(restantes),
                  ),
                if (estado == EstadoVisible.vencido)
                  fila(
                    Icons.warning_amber_rounded,
                    'Días de retraso',
                    formatoDias(-restantes),
                    color: AppColores.rojo,
                  ),
                if (estado == EstadoVisible.devuelto &&
                    prestamo.fechaEntrega != null)
                  fila(
                    Icons.assignment_turned_in_outlined,
                    'Fecha de entrega',
                    formatoFecha(prestamo.fechaEntrega!),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (estado == EstadoVisible.vencido)
            const Aviso(
              tipo: TipoAviso.error,
              mensaje:
                  'El préstamo está vencido. El estudiante no podrá pedir '
                  'otro libro hasta devolverlo.',
            ),
          if (estado == EstadoVisible.devuelto)
            const Aviso(
              mensaje:
                  'Este préstamo ya fue devuelto. Un préstamo devuelto no '
                  'puede volver a estado activo.',
            ),
        ],
      ),
      bottomNavigationBar: prestamo.activo
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: FilledButton.icon(
                  onPressed: guardando
                      ? null
                      : () => registrarDevolucion(prestamo),
                  icon: const Icon(Icons.assignment_return_outlined),
                  label: const Text('Registrar devolución'),
                ),
              ),
            )
          : null,
    );
  }
}
