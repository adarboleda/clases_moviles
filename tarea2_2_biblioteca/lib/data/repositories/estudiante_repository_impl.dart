import '../../domain/entities/estudiante.dart';
import '../../domain/repositories/estudiante_repository.dart';
import '../datasources/estudiante_api.dart';
import '../models/estudiante_model.dart';

class EstudianteRepositoryImpl implements EstudianteRepository {
  final EstudianteApi api;

  EstudianteRepositoryImpl({required this.api});

  @override
  Future<List<Estudiante>> obtenerEstudiantes() {
    return api.obtenerEstudiantes();
  }

  @override
  Future<Estudiante> registrarEstudiante(Estudiante estudiante) {
    return api.registrarEstudiante(EstudianteModel.desdeEntidad(estudiante));
  }
}
