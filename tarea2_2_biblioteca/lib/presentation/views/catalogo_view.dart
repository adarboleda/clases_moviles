import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routes/app_routes.dart';
import '../viewmodels/libro_viewmodel.dart';
import '../widgets/barra_busqueda.dart';
import '../widgets/filtro_categorias.dart';
import '../widgets/tarjeta_libro_lista.dart';
import '../widgets/vista_estado.dart';

class CatalogoView extends StatelessWidget {
  const CatalogoView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LibroViewModel>();
    final lista = vm.librosFiltrados;
    final conStock = vm.libros.where((libro) => libro.disponible).length;
    final textos = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo')),
      body: RefreshIndicator(
        onRefresh: vm.cargar,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Libros de la biblioteca',
                          style: textos.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Consulta la disponibilidad de cada libro. '
                          '$conStock de ${vm.libros.length} títulos tienen '
                          'ejemplares disponibles.',
                          style: textos.bodyMedium?.copyWith(
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        BarraBusqueda(
                          valorInicial: vm.busqueda,
                          onChanged: vm.buscar,
                        ),
                        const SizedBox(height: 12),
                        FilterChip(
                          label: const Text('Solo disponibles'),
                          avatar: Icon(
                            vm.soloDisponibles
                                ? Icons.check_circle
                                : Icons.circle_outlined,
                            size: 18,
                            color: vm.soloDisponibles ? Colors.white : null,
                          ),
                          selected: vm.soloDisponibles,
                          labelStyle: TextStyle(
                            color: vm.soloDisponibles ? Colors.white : null,
                          ),
                          onSelected: vm.cambiarSoloDisponibles,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  FiltroCategorias(
                    categorias: vm.categorias,
                    seleccionada: vm.categoria,
                    onSeleccionar: vm.seleccionarCategoria,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            if (lista.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: VistaEstado(
                  cargando: vm.cargando,
                  error: vm.error,
                  vacio: true,
                  mensajeVacio: 'No se encontraron libros',
                  onReintentar: vm.cargar,
                  child: const SizedBox(),
                ),
              )
            else
              SliverList.separated(
                itemCount: lista.length,
                separatorBuilder: (_, _) => const SizedBox(height: 24),
                itemBuilder: (context, indice) {
                  final libro = lista[indice];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TarjetaLibroLista(
                      libro: libro,
                      onDetalle: () => Navigator.pushNamed(
                        context,
                        AppRoutes.detalleLibro,
                        arguments: libro,
                      ),
                    ),
                  );
                },
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}
