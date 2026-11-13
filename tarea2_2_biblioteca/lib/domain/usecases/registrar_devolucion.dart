import '../entities/prestamo.dart';
import '../errores/biblioteca_exception.dart';
import '../reglas/reglas_prestamo.dart';
import '../repositories/prestamo_repository.dart';

class RegistrarDevolucion {
  final PrestamoRepository repository;

  RegistrarDevolucion(this.repository);

  //metodo ejecutar: el prestamo pasa a devuelto y la API suma 1 al stock del libro
  Future<Prestamo> ejecutar(Prestamo prestamo) {
    final error = ReglasPrestamo.validarDevolucion(prestamo);
    if (error != null) throw ReglaNegocioException(error);
    return repository.registrarDevolucion(prestamo.id!);
  }
}
