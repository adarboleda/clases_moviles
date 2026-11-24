import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/pelicula.dart';
import '../../routes/app_routes.dart';
import '../theme/app_theme.dart';
import '../utils/formato.dart';
import '../viewmodels/reserva_viewmodel.dart';
import '../widgets/poster_pelicula.dart';

class ReservaView extends StatefulWidget {
  final Pelicula pelicula;

  const ReservaView({super.key, required this.pelicula});

  @override
  State<ReservaView> createState() => _ReservaViewState();
}

class _ReservaViewState extends State<ReservaView> {
  @override
  void initState() {
    super.initState();
    context.read<ReservaViewModel>().iniciarReserva(widget.pelicula);
  }

  Future<void> _elegirFecha(ReservaViewModel vm) async {
    final hoy = DateTime.now();
    final fecha = await showDatePicker(
      context: context,
      initialDate: vm.fecha ?? hoy,
      firstDate: hoy,
      lastDate: hoy.add(const Duration(days: 365)),
      helpText: 'Fecha de la función',
    );
    if (fecha != null) vm.seleccionarFecha(fecha);
  }

  Future<void> _elegirHora(ReservaViewModel vm) async {
    final hora = await showTimePicker(
      context: context,
      initialTime: vm.hora ?? const TimeOfDay(hour: 18, minute: 0),
      helpText: 'Hora de la función',
    );
    if (hora != null) vm.seleccionarHora(hora);
  }

  /// Va a la pantalla "Procesando compra", que registra la reserva y vuelve al inicio.
  void _guardar() {
    Navigator.pushReplacementNamed(context, AppRoutes.procesando);
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ReservaViewModel>();
    final p = widget.pelicula;

    return Scaffold(
      appBar: AppBar(title: const Text('Reserva de boletos')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Encabezado con póster + datos de la película seleccionada
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: PosterPelicula(
                    pelicula: p,
                    emojiSize: 44,
                    mostrarTitulo: false,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.titulo.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.schedule,
                          size: 16,
                          color: AppColors.textoSecundario,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '${p.duracion} · ${p.clasificacion}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.textoSecundario,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Chip(
                      label: Text(p.genero),
                      backgroundColor: AppColors.tarjeta,
                      side: BorderSide.none,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (p.sinopsis.isNotEmpty) ...[
            const SizedBox(height: 20),
            Text(
              p.sinopsis,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColors.textoSecundario),
            ),
          ],
          const SizedBox(height: 28),
          const Text(
            'Selecciona la fecha y hora',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 16),
          _SelectorTile(
            icono: Icons.calendar_month,
            titulo: 'Fecha de la función',
            valor: vm.fecha == null ? 'Toca para elegir' : formatearFecha(vm.fecha!),
            seleccionado: vm.fecha != null,
            onTap: () => _elegirFecha(vm),
          ),
          const SizedBox(height: 12),
          _SelectorTile(
            icono: Icons.access_time,
            titulo: 'Hora de la función',
            valor: vm.hora == null ? 'Toca para elegir' : vm.hora!.format(context),
            seleccionado: vm.hora != null,
            onTap: () => _elegirHora(vm),
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 54,
            child: FilledButton(
              onPressed: vm.puedeGuardar ? _guardar : null,
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                textStyle: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: const Text('Guardar reserva'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectorTile extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String valor;
  final bool seleccionado;
  final VoidCallback onTap;

  const _SelectorTile({
    required this.icono,
    required this.titulo,
    required this.valor,
    required this.seleccionado,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.tarjeta,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icono, color: AppColors.acento, size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(
                        color: AppColors.textoSecundario,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      valor,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: seleccionado ? AppColors.acento : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textoSecundario),
            ],
          ),
        ),
      ),
    );
  }
}
