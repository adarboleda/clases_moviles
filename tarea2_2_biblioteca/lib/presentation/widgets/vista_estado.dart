import 'package:flutter/material.dart';

import '../theme/app_tema.dart';

//muestra carga, error o lista vacia; si ya hay datos muestra el contenido
class VistaEstado extends StatelessWidget {
  final bool cargando;
  final String error;
  final bool vacio;
  final String mensajeVacio;
  final VoidCallback onReintentar;
  final Widget child;

  const VistaEstado({
    super.key,
    required this.cargando,
    required this.error,
    required this.vacio,
    required this.mensajeVacio,
    required this.onReintentar,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!vacio) return child;
    if (cargando) return const Center(child: CircularProgressIndicator());

    final hayError = error.isNotEmpty;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              hayError ? Icons.cloud_off : Icons.inbox_outlined,
              size: 44,
              color: AppColores.textoSuave,
            ),
            const SizedBox(height: 10),
            Text(
              hayError ? error : mensajeVacio,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (hayError) ...[
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: onReintentar,
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
