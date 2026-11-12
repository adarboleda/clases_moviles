import '../../domain/entities/producto.dart';
import '../../domain/repositories/producto_repository.dart';
import '../datasources/producto_api.dart';
import '../models/producto_model.dart';

class ProductoRepositoryImpl implements ProductoRepository {
  final ProductoApi api;

  ProductoRepositoryImpl({required this.api});

  @override
  Future<List<Producto>> obtenerProductos() {
    return api.obtenerProductos();
  }

  @override
  Future<Producto> crearProducto(Producto producto) {
    final model = ProductoModel(
      id: producto.id,
      nombre: producto.nombre,
      descripcion: producto.descripcion,
      precio: producto.precio,
    );
    return api.crearProductos(model);
  }

  @override
  Future<Producto> actualizarProducto(Producto producto) {
    final model = ProductoModel(
      id: producto.id,
      nombre: producto.nombre,
      descripcion: producto.descripcion,
      precio: producto.precio,
    );
    return api.actualizarProducto(model);
  }

  @override
  Future<void> eliminarProducto(int id) {
    return api.eliminarProducto(id);
  }
}
