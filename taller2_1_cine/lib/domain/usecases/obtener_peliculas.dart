import '../entities/pelicula.dart';
import '../repositories/pelicula_repository.dart';

class ObtenerPeliculas {
  final PeliculaRepository repository;

  ObtenerPeliculas(this.repository);

  Future<List<Pelicula>> call() => repository.obtenerPeliculas();
}
