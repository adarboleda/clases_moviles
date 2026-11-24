import '../../domain/entities/pelicula.dart';
import '../../domain/repositories/pelicula_repository.dart';
import '../datasources/pelicula_local_datasource.dart';
import '../datasources/pelicula_remote_datasource.dart';

/// Intenta la API (OMDb); si no hay red o falla, usa la cartelera local.
class PeliculaRepositoryImpl implements PeliculaRepository {
  final PeliculaRemoteDatasource remote;
  final PeliculaLocalDatasource local;

  PeliculaRepositoryImpl(this.remote, this.local);

  @override
  Future<List<Pelicula>> obtenerPeliculas() async {
    try {
      return await remote.obtenerCartelera();
    } catch (_) {
      return local.obtenerCartelera();
    }
  }
}
