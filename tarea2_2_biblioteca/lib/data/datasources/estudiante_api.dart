import '../models/estudiante_model.dart';
import 'api_cliente.dart';

class EstudianteApi {
  final ApiCliente cliente;

  EstudianteApi(this.cliente);

  //metodo para obtener estudiantes
  Future<List<EstudianteModel>> obtenerEstudiantes() async {
    final datos = await cliente.get('/estudiantes') as List;
    return datos.map((item) => EstudianteModel.fromJson(item)).toList();
  }

  //metodo para registrar estudiante
  Future<EstudianteModel> registrarEstudiante(
    EstudianteModel estudiante,
  ) async {
    final datos = await cliente.post('/estudiantes', estudiante.toJson());
    return EstudianteModel.fromJson(datos);
  }
}
