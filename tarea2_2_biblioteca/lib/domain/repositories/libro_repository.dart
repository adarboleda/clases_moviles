import '../entities/libro.dart';

abstract class LibroRepository {
  Future<List<Libro>> obtenerLibros({bool soloDisponibles = false});
  Future<Libro> obtenerLibro(int id);
}
