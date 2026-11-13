import '../entities/prestamo.dart';

abstract class PrestamoRepository {
  Future<List<Prestamo>> obtenerPrestamos({int? estudianteId});
  Future<Prestamo> registrarPrestamo(Prestamo prestamo);
  Future<Prestamo> registrarDevolucion(int id);
}
