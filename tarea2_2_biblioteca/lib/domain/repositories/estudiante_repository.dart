import '../entities/estudiante.dart';

abstract class EstudianteRepository {
  Future<List<Estudiante>> obtenerEstudiantes();
  Future<Estudiante> registrarEstudiante(Estudiante estudiante);
}
