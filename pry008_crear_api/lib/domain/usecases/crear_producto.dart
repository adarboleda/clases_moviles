import '../entities/producto.dart';
import '../repositories/producto_repository.dart';

class CrearProducto {
  final ProductoRepository repository;

  CrearProducto(this.repository);

  //metodo ejecutar

  Future<Producto> crear(Producto producto) {
    return repository.crearProducto(producto);
  }
}
