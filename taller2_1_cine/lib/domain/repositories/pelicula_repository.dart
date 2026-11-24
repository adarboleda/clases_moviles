import '../entities/pelicula.dart';

abstract class PeliculaRepository {
  Future<List<Pelicula>> obtenerPeliculas();
}
