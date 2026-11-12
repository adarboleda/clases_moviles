import '../repositories/producto_repository.dart';

class EliminarProducto {
  final ProductoRepository repository;

  EliminarProducto(this.repository);

  //metodo ejecutar
  Future<void> ejecutar(int id) {
    return repository.eliminarProducto(id);
  }
}
