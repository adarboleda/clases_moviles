import '../entities/estudiante.dart';
import '../repositories/estudiante_repository.dart';

class ObtenerEstudiantes {
  final EstudianteRepository repository;

  ObtenerEstudiantes(this.repository);

  //metodo ejecutar
  Future<List<Estudiante>> ejecutar() {
    return repository.obtenerEstudiantes();
  }
}
