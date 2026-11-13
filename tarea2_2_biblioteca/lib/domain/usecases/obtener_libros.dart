import '../entities/libro.dart';
import '../repositories/libro_repository.dart';

class ObtenerLibros {
  final LibroRepository repository;

  ObtenerLibros(this.repository);

  //metodo ejecutar
  Future<List<Libro>> ejecutar({bool soloDisponibles = false}) {
    return repository.obtenerLibros(soloDisponibles: soloDisponibles);
  }
}
