import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routes/app_routes.dart';
import '../theme/app_tema.dart';
import '../utils/recargar.dart';
import '../viewmodels/libro_viewmodel.dart';
import '../viewmodels/prestamo_viewmodel.dart';
import '../widgets/barra_busqueda.dart';
import '../widgets/filtro_categorias.dart';
import '../widgets/seccion_titulo.dart';
import '../widgets/tarjeta_libro_carrusel.dart';
import '../widgets/tarjeta_prestamo.dart';
import '../widgets/vista_estado.dart';

class ExplorarView extends StatelessWidget {
  final VoidCallback onVerPrestamos;

  const ExplorarView({super.key, required this.onVerPrestamos});

  @override
  Widget build(BuildContext context) {
    final libros = context.watch<LibroViewModel>();
    final prestamos = context.watch<PrestamoViewModel>();
    final disponibles = libros.disponibles;

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () => recargarTodo(context),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 12, 0),
              child: Row(
                children: [
                  const _IconoApp(),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Biblioteca',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          'Universitaria',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Catálogo completo',
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.catalogo),
                    icon: const Icon(Icons.local_library_outlined),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: BarraBusqueda(
                valorInicial: libros.busqueda,
                onChanged: libros.buscar,
              ),
            ),
            FiltroCategorias(
              categorias: libros.categorias,
              seleccionada: libros.categoria,
              onSeleccionar: libros.seleccionarCategoria,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 8, 4),
              child: SeccionTitulo(
                titulo: 'Libros disponibles',
                accion: 'Ver todos',
                onAccion: () =>
                    Navigator.pushNamed(context, AppRoutes.catalogo),
              ),
            ),
            SizedBox(
              height: 262,
              child: VistaEstado(
                cargando: libros.cargando,
                error: libros.error,
                vacio: disponibles.isEmpty,
                mensajeVacio: 'No hay libros disponibles con ese filtro',
                onReintentar: () => recargarTodo(context),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
                  itemCount: disponibles.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 18),
                  itemBuilder: (context, indice) {
                    final libro = disponibles[indice];
                    return TarjetaLibroCarrusel(
                      libro: libro,
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.detalleLibro,
                        arguments: libro,
                      ),
                    );
                  },
                ),
              ),
            ),
            _PanelPrestamos(prestamos: prestamos, onVerTodos: onVerPrestamos),
          ],
        ),
      ),
    );
  }
}

//panel verde con los prestamos que deben devolverse primero
class _PanelPrestamos extends StatelessWidget {
  final PrestamoViewModel prestamos;
  final VoidCallback onVerTodos;

  const _PanelPrestamos({required this.prestamos, required this.onVerTodos});

  @override
  Widget build(BuildContext context) {
    final activos = prestamos.activos;

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      decoration: const BoxDecoration(
        color: AppColores.verde,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SeccionTitulo(
            titulo: 'Préstamos activos (${activos.length})',
            accion: 'Ver todos',
            onAccion: onVerTodos,
            color: Colors.white,
          ),
          const SizedBox(height: 4),
          if (activos.isEmpty)
            Text(
              prestamos.error.isNotEmpty
                  ? prestamos.error
                  : 'No hay préstamos activos',
              style: const TextStyle(color: Colors.white70),
            )
          else
            for (final prestamo in activos.take(3))
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TarjetaPrestamo(
                  prestamo: prestamo,
                  estado: prestamos.estadoDe(prestamo),
                  hoy: prestamos.hoy,
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

//icono de cuadros como en la referencia
class _IconoApp extends StatelessWidget {
  const _IconoApp();

  @override
  Widget build(BuildContext context) {
    Widget cuadro(Color color) => Container(
      width: 11,
      height: 11,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            cuadro(AppColores.texto),
            const SizedBox(width: 3),
            cuadro(AppColores.texto),
          ],
        ),
        const SizedBox(height: 3),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            cuadro(AppColores.texto),
            const SizedBox(width: 3),
            cuadro(AppColores.verde),
          ],
        ),
      ],
    );
  }
}
