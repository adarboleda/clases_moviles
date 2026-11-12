import '../entities/producto.dart';

abstract class ProductoRepository {
  //operaciones CRUD
  Future<List<Producto>> obtenerProductos();
  Future<Producto> crearProducto(Producto producto);
  Future<Producto> actualizarProducto(Producto producto);
  Future<void> eliminarProducto(int id);
}
