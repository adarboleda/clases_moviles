import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/fechas.dart';
import '../../domain/entities/libro.dart';
import '../../domain/errores/biblioteca_exception.dart';
import '../../domain/reglas/reglas_prestamo.dart';
import '../utils/formato.dart';
import '../viewmodels/estudiante_viewmodel.dart';
import '../viewmodels/libro_viewmodel.dart';
import '../viewmodels/prestamo_viewmodel.dart';
import '../widgets/aviso.dart';
import '../widgets/campo_fecha.dart';
import '../widgets/etiqueta_stock.dart';
import '../widgets/portada_libro.dart';

class FormularioPrestamoView extends StatefulWidget {
  const FormularioPrestamoView({super.key});

  @override
  State<FormularioPrestamoView> createState() => _FormularioPrestamoViewState();
}

class _FormularioPrestamoViewState extends State<FormularioPrestamoView> {
  late Libro libro;
  int? estudianteId;
  late DateTime fechaPrestamo;
  late DateTime fechaDevolucion;
  bool guardando = false;
  String? errorEnvio;
  bool _inicializado = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_inicializado) return;
    _inicializado = true;

    //recibir el libro enviado desde el detalle
    libro = ModalRoute.of(context)!.settings.arguments as Libro;
    fechaPrestamo = context.read<PrestamoViewModel>().hoy;
    fechaDevolucion = fechaPrestamo.add(
      const Duration(days: ReglasPrestamo.maximoDias),
    );
  }

  Future<void> elegirFechaPrestamo() async {
    final hoy = context.read<PrestamoViewModel>().hoy;
    final elegida = await showDatePicker(
      context: context,
      helpText: 'Fecha de préstamo',
      initialDate: fechaPrestamo,
      firstDate: hoy.subtract(const Duration(days: 30)),
      lastDate: hoy,
    );
    if (elegida == null) return;

    //se conserva la duracion que ya estaba elegida
    final duracion = diasEntre(fechaPrestamo, fechaDevolucion);
    setState(() {
      fechaPrestamo = soloFecha(elegida);
      fechaDevolucion = fechaPrestamo.add(Duration(days: duracion));
      errorEnvio = null;
    });
  }

  Future<void> elegirFechaDevolucion() async {
    final elegida = await showDatePicker(
      context: context,
      helpText: 'Fecha de devolución',
      initialDate: fechaDevolucion,
      firstDate: fechaPrestamo.subtract(const Duration(days: 30)),
      lastDate: fechaPrestamo.add(const Duration(days: 60)),
    );
    if (elegida == null) return;
    setState(() {
      fechaDevolucion = soloFecha(elegida);
      errorEnvio = null;
    });
  }

  void usarDuracion(int dias) {
    setState(() {
      fechaDevolucion = fechaPrestamo.add(Duration(days: dias));
      errorEnvio = null;
    });
  }

  Future<void> registrar() async {
    if (estudianteId == null) {
      setState(() => errorEnvio = 'Seleccione un estudiante');
      return;
    }

    final navigator = Navigator.of(context);
    final prestamos = context.read<PrestamoViewModel>();
    final libros = context.read<LibroViewModel>();

    setState(() {
      guardando = true;
      errorEnvio = null;
    });

    try {
      await prestamos.registrar(
        estudianteId: estudianteId!,
        libroId: libro.id,
        fechaPrestamo: fechaPrestamo,
        fechaDevolucion: fechaDevolucion,
      );
      //el stock del libro cambio en la API
      await libros.cargar();
      navigator.pop(true);
    } on BibliotecaException catch (e) {
      setState(() => errorEnvio = e.mensaje);
    } catch (_) {
      setState(() => errorEnvio = 'No se pudo registrar el préstamo');
    } finally {
      if (mounted) setState(() => guardando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final estudiantes = context.watch<EstudianteViewModel>().estudiantes;
    final prestamos = context.watch<PrestamoViewModel>();
    final textos = Theme.of(context).textTheme;

    final duracion = diasEntre(fechaPrestamo, fechaDevolucion);
    final errorFechas = ReglasPrestamo.validarFechas(
      fechaPrestamo,
      fechaDevolucion,
    );
    final bloqueo = estudianteId == null
        ? null
        : prestamos.motivoBloqueo(estudianteId!);

    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo préstamo')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  PortadaLibro(
                    url: libro.portadaUrl,
                    titulo: libro.titulo,
                    ancho: 56,
                    alto: 80,
                    radio: 8,
                    sombra: false,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(libro.titulo, style: textos.titleMedium),
                        const SizedBox(height: 2),
                        Text(libro.autor, style: textos.bodyMedium),
                        const SizedBox(height: 8),
                        EtiquetaStock(
                          libro:
                              context.watch<LibroViewModel>().libroPorId(
                                libro.id,
                              ) ??
                              libro,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Estudiante', style: textos.titleMedium),
          const SizedBox(height: 8),
          DropdownButtonFormField<int>(
            initialValue: estudianteId,
            isExpanded: true,
            hint: const Text('Seleccione un estudiante'),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person_outline),
            ),
            items: [
              for (final estudiante in estudiantes)
                DropdownMenuItem(
                  value: estudiante.id,
                  child: Text(
                    '${estudiante.nombre} · ${estudiante.cedula}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
            onChanged: (valor) => setState(() {
              estudianteId = valor;
              errorEnvio = null;
            }),
          ),
          if (estudianteId != null) ...[
            const SizedBox(height: 10),
            Aviso(
              tipo: bloqueo == null ? TipoAviso.exito : TipoAviso.error,
              mensaje:
                  bloqueo ??
                  'Puede solicitar el préstamo '
                      '(${prestamos.activosDe(estudianteId!)} de '
                      '${ReglasPrestamo.maximoActivos} préstamos activos)',
            ),
          ],
          const SizedBox(height: 24),
          Text('Fechas', style: textos.titleMedium),
          const SizedBox(height: 8),
          CampoFecha(
            etiqueta: 'Fecha de préstamo',
            fecha: fechaPrestamo,
            icono: Icons.event,
            onTap: elegirFechaPrestamo,
          ),
          const SizedBox(height: 12),
          CampoFecha(
            etiqueta: 'Fecha de devolución',
            fecha: fechaDevolucion,
            icono: Icons.event_available,
            onTap: elegirFechaDevolucion,
            error: errorFechas,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final dias in const [1, 3, 5, 7])
                ChoiceChip(
                  label: Text(formatoDias(dias)),
                  selected: duracion == dias,
                  labelStyle: TextStyle(
                    color: duracion == dias ? Colors.white : null,
                  ),
                  onSelected: (_) => usarDuracion(dias),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Duración: ${formatoDias(duracion)} '
            '(máximo ${ReglasPrestamo.maximoDias} días)',
            style: textos.bodyMedium,
          ),
          if (errorEnvio != null) ...[
            const SizedBox(height: 16),
            Aviso(tipo: TipoAviso.error, mensaje: errorEnvio!),
          ],
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: FilledButton.icon(
            onPressed: guardando ? null : registrar,
            icon: guardando
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.check),
            label: const Text('Registrar préstamo'),
          ),
        ),
      ),
    );
  }
}
