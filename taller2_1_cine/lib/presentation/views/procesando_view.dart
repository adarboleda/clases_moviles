import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/app_theme.dart';
import '../viewmodels/reserva_viewmodel.dart';

/// Pantalla "Procesando compra": simula el registro de la compra y, al llegar
/// al 100 %, guarda la reserva (SharedPreferences) y regresa al inicio.
class ProcesandoView extends StatefulWidget {
  const ProcesandoView({super.key});

  @override
  State<ProcesandoView> createState() => _ProcesandoViewState();
}

class _ProcesandoViewState extends State<ProcesandoView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _terminado = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) _finalizar();
      });
    _controller.forward();
  }

  Future<void> _finalizar() async {
    final vm = context.read<ReservaViewModel>();
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    final ok = await vm.guardar();
    if (!mounted) return;
    setState(() => _terminado = true);

    // Deja ver el mensaje de éxito un momento antes de volver.
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    navigator.pop();
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          ok ? 'Compra registrada correctamente' : 'No se pudo registrar la compra',
        ),
      ),
    );
  }

  String _estado(double progreso) {
    if (_terminado) return '¡Compra registrada!';
    if (progreso < 0.25) return 'Verificando datos...';
    if (progreso < 0.55) return 'Reservando asiento...';
    if (progreso < 0.90) return 'Registrando compra...';
    return 'Finalizando...';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // no se puede cancelar a mitad
        title: const Text('Procesando compra'),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final progreso = _controller.value;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 190,
                  height: 190,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox.expand(
                        child: CircularProgressIndicator(
                          value: progreso,
                          strokeWidth: 14,
                          strokeCap: StrokeCap.round,
                          backgroundColor: AppColors.tarjeta,
                          color: AppColors.acento,
                        ),
                      ),
                      _terminado
                          ? const Icon(
                              Icons.check_circle,
                              size: 80,
                              color: AppColors.acento,
                            )
                          : Text(
                              '${(progreso * 100).round()}%',
                              style: const TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _estado(progreso),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progreso,
                    minHeight: 8,
                    backgroundColor: AppColors.tarjeta,
                    color: AppColors.acento,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
