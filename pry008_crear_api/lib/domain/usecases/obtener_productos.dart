import '../entities/producto.dart';
import '../repositories/producto_repository.dart';

class ObtenerProductos {
  final ProductoRepository repository;

  ObtenerProductos(this.repository);

  //metodo ejecutar

  Future<List<Producto>> ejecutar() {
    return repository.obtenerProductos();
  }
}
