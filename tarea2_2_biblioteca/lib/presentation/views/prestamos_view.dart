import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routes/app_routes.dart';
import '../theme/app_tema.dart';
import '../utils/recargar.dart';
import '../viewmodels/prestamo_viewmodel.dart';
import '../widgets/tarjeta_prestamo.dart';
import '../widgets/vista_estado.dart';

class PrestamosView extends StatelessWidget {
  const PrestamosView({super.key});

  String _etiqueta(PrestamoViewModel vm, FiltroPrestamo filtro) {
    switch (filtro) {
      case FiltroPrestamo.activos:
        return 'Activos (${vm.activos.length})';
      case FiltroPrestamo.vencidos:
        return 'Vencidos (${vm.vencidos.length})';
      case FiltroPrestamo.devueltos:
        return 'Devueltos (${vm.devueltos.length})';
      case FiltroPrestamo.todos:
        return 'Todos (${vm.prestamos.length})';
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PrestamoViewModel>();
    final lista = vm.filtrados;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 8, 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Préstamos',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                IconButton(
                  tooltip: 'Nuevo préstamo',
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.catalogo),
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: AppColores.naranja,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                for (final filtro in FiltroPrestamo.values)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(_etiqueta(vm, filtro)),
                      selected: vm.filtro == filtro,
                      labelStyle: TextStyle(
                        color: vm.filtro == filtro ? Colors.white : null,
                      ),
                      onSelected: (_) => vm.cambiarFiltro(filtro),
                    ),
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
                vacio: lista.isEmpty,
                mensajeVacio: 'No hay préstamos en esta lista',
                onReintentar: () => recargarTodo(context),
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: lista.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, indice) {
                    final prestamo = lista[indice];
                    return TarjetaPrestamo(
                      prestamo: prestamo,
                      estado: vm.estadoDe(prestamo),
                      hoy: vm.hoy,
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.detallePrestamo,
                        arguments: prestamo,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
