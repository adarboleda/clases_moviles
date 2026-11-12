import 'package:flutter/material.dart';

import '../../domain/entities/producto.dart';
import '../../domain/usecases/obtener_productos.dart';
import '../../domain/usecases/crear_producto.dart';
import '../../domain/usecases/actualizar_producto.dart';
import '../../domain/usecases/eliminar_producto.dart';

class ProductoViewModel extends ChangeNotifier {
  final ObtenerProductos obtener;
  final CrearProducto crear;
  final ActualizarProducto actualizar;
  final EliminarProducto eliminar;

  ProductoViewModel(this.obtener, this.crear, this.actualizar, this.eliminar);

  List<Producto> productos = [];
  bool cargando = false;
  String error = '';

  Future<void> cargar() async {
    cargando = true;
    notifyListeners();

    try {
      productos = await obtener.ejecutar();
      error = '';
    } catch (e) {
      error = 'Error al cargar productos';
    }

    cargando = false;
    notifyListeners();
  }

  Future<void> agregar(Producto producto) async {
    await crear.crear(producto);
    await cargar();
  }

  Future<void> editar(Producto producto) async {
    await actualizar.ejecutar(producto);
    await cargar();
  }

  Future<void> borrar(int id) async {
    await eliminar.ejecutar(id);
    await cargar();
  }
}
