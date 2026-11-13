import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/libro.dart';
import '../../routes/app_routes.dart';
import '../theme/app_tema.dart';
import '../viewmodels/libro_viewmodel.dart';
import '../widgets/fila_datos.dart';
import '../widgets/portada_libro.dart';

class DetalleLibroView extends StatelessWidget {
  const DetalleLibroView({super.key});

  Future<void> solicitarPrestamo(BuildContext context, Libro libro) async {
    final registrado = await Navigator.pushNamed(
      context,
      AppRoutes.nuevoPrestamo,
      arguments: libro,
    );
    if (registrado == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Préstamo registrado. El stock se actualizó.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final argumento = ModalRoute.of(context)!.settings.arguments as Libro;
    //se usa la version actual del libro para mostrar el stock actualizado
    final libro =
        context.watch<LibroViewModel>().libroPorId(argumento.id) ?? argumento;
    final textos = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del libro')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 36),
              child: Center(
                child: PortadaLibro(
                  url: libro.portadaUrl,
                  titulo: libro.titulo,
                  ancho: 170,
                  alto: 250,
                  radio: 12,
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              decoration: const BoxDecoration(
                color: AppColores.superficie,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              libro.categoria,
                              style: const TextStyle(
                                color: AppColores.verde,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(libro.titulo, style: textos.titleLarge),
                            const SizedBox(height: 4),
                            Text(
                              libro.autor,
                              style: textos.bodyMedium?.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: libro.disponible
                            ? AppColores.verde
                            : AppColores.rojo,
                        child: Icon(
                          libro.disponible
                              ? Icons.bookmark_added
                              : Icons.bookmark_remove,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  FilaDatos(
                    datos: [
                      (
                        'Disponibles',
                        '${libro.stockDisponible} de ${libro.stockTotal}',
                      ),
                      ('Páginas', '${libro.paginas}'),
                      ('Año', '${libro.anio}'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text('Descripción', style: textos.titleMedium),
                  const SizedBox(height: 8),
                  Text(
                    libro.descripcion,
                    style: textos.bodyMedium?.copyWith(
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: AppColores.superficie,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
            child: Row(
              children: [
                Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColores.gris,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text('Stock', style: textos.bodyMedium),
                      const SizedBox(width: 14),
                      Text(
                        '${libro.stockDisponible}',
                        style: TextStyle(
                          color: libro.disponible
                              ? AppColores.verde
                              : AppColores.rojo,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: libro.disponible
                        ? () => solicitarPrestamo(context, libro)
                        : null,
                    child: Text(
                      libro.disponible ? 'Solicitar préstamo' : 'Sin stock',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
