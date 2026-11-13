import '../../domain/entities/prestamo.dart';
import '../../domain/repositories/prestamo_repository.dart';
import '../datasources/prestamo_api.dart';
import '../models/prestamo_model.dart';

class PrestamoRepositoryImpl implements PrestamoRepository {
  final PrestamoApi api;

  PrestamoRepositoryImpl({required this.api});

  @override
  Future<List<Prestamo>> obtenerPrestamos({int? estudianteId}) {
    return api.obtenerPrestamos(estudianteId: estudianteId);
  }

  @override
  Future<Prestamo> registrarPrestamo(Prestamo prestamo) {
    return api.registrarPrestamo(PrestamoModel.desdeEntidad(prestamo));
  }

  @override
  Future<Prestamo> registrarDevolucion(int id) {
    return api.registrarDevolucion(id);
  }
}
