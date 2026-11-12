import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/datasources/producto_api.dart';
import 'data/repositories/producto_repository_impl.dart';

import 'domain/usecases/obtener_productos.dart';
import 'domain/usecases/crear_producto.dart';
import 'domain/usecases/actualizar_producto.dart';
import 'domain/usecases/eliminar_producto.dart';

import 'presentation/viewmodels/producto_viewmodel.dart';
import 'presentation/views/inicio_view.dart';
import 'presentation/views/productos_view.dart';
import 'presentation/views/formulario_producto_view.dart';
import 'presentation/views/detalle_producto_view.dart';

import 'routes/app_routes.dart';

void main() {
  final api = ProductoApi();

  final repository =
      ProductoRepositoryImpl(api: api);

  final obtener =
      ObtenerProductos(repository);

  final crear =
      CrearProducto(repository);

  final actualizar =
      ActualizarProducto(repository);

  final eliminar =
      EliminarProducto(repository);

  runApp(
    ChangeNotifierProvider(
      create: (_) => ProductoViewModel(
        obtener,
        crear,
        actualizar,
        eliminar,
      ),
      child: const MiApp(),
    ),
  );
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.inicio,
      routes: {
        AppRoutes.inicio:
            (_) => const InicioView(),
        AppRoutes.productos:
            (_) => const ProductosView(),
        AppRoutes.formulario:
            (_) => const FormularioProductoView(),
        AppRoutes.detalle:
            (_) => const DetalleProductoView(),
      },
    );
  }
}
