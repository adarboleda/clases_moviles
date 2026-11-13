import '../entities/prestamo.dart';
import '../repositories/prestamo_repository.dart';

class ObtenerPrestamos {
  final PrestamoRepository repository;

  ObtenerPrestamos(this.repository);

  //metodo ejecutar
  Future<List<Prestamo>> ejecutar({int? estudianteId}) {
    return repository.obtenerPrestamos(estudianteId: estudianteId);
  }
}
