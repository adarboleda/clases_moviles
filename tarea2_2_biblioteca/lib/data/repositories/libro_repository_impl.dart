import '../../domain/entities/libro.dart';
import '../../domain/repositories/libro_repository.dart';
import '../datasources/libro_api.dart';

class LibroRepositoryImpl implements LibroRepository {
  final LibroApi api;

  LibroRepositoryImpl({required this.api});

  @override
  Future<List<Libro>> obtenerLibros({bool soloDisponibles = false}) {
    return api.obtenerLibros(soloDisponibles: soloDisponibles);
  }

  @override
  Future<Libro> obtenerLibro(int id) {
    return api.obtenerLibro(id);
  }
}
