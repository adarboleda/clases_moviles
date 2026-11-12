import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:pry008_crear_api/domain/entities/producto.dart';
import 'package:pry008_crear_api/domain/repositories/producto_repository.dart';
import 'package:pry008_crear_api/domain/usecases/actualizar_producto.dart';
import 'package:pry008_crear_api/domain/usecases/crear_producto.dart';
import 'package:pry008_crear_api/domain/usecases/eliminar_producto.dart';
import 'package:pry008_crear_api/domain/usecases/obtener_productos.dart';
import 'package:pry008_crear_api/main.dart';
import 'package:pry008_crear_api/presentation/viewmodels/producto_viewmodel.dart';

class _RepositorioFalso implements ProductoRepository {
  @override
  Future<List<Producto>> obtenerProductos() async => [
        Producto(id: 1, nombre: 'Laptop', descripcion: 'Demo', precio: 10),
      ];

  @override
  Future<Producto> crearProducto(Producto producto) async => producto;

  @override
  Future<Producto> actualizarProducto(Producto producto) async => producto;

  @override
  Future<void> eliminarProducto(int id) async {}
}

void main() {
  testWidgets('Muestra la lista de productos', (WidgetTester tester) async {
    final repo = _RepositorioFalso();

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ProductoViewModel(
          ObtenerProductos(repo),
          CrearProducto(repo),
          ActualizarProducto(repo),
          EliminarProducto(repo),
        ),
        child: const MiApp(),
      ),
    );

    expect(find.text('CRUD de Productos'), findsOneWidget);

    await tester.tap(find.text('Ver productos'));
    await tester.pumpAndSettle();

    expect(find.text('Laptop'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
