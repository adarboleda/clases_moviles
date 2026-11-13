import '../entities/estudiante.dart';
import '../errores/biblioteca_exception.dart';
import '../reglas/validador_estudiante.dart';
import '../repositories/estudiante_repository.dart';

class RegistrarEstudiante {
  final EstudianteRepository repository;

  RegistrarEstudiante(this.repository);

  //metodo ejecutar
  Future<Estudiante> ejecutar(Estudiante estudiante) {
    final error = ValidadorEstudiante.validar(estudiante);
    if (error != null) throw ReglaNegocioException(error);
    return repository.registrarEstudiante(estudiante);
  }
}
