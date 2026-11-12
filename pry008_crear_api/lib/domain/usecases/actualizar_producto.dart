import '../entities/producto.dart';
import '../repositories/producto_repository.dart';

class ActualizarProducto {
  final ProductoRepository repository;

  ActualizarProducto(this.repository);

  //metodo ejecutar

  Future<Producto> ejecutar(Producto producto) {
    return repository.actualizarProducto(producto);
  }
}
