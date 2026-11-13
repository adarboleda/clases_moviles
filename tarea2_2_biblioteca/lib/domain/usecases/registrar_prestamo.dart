import '../../core/fechas.dart';
import '../entities/prestamo.dart';
import '../errores/biblioteca_exception.dart';
import '../reglas/reglas_prestamo.dart';
import '../repositories/libro_repository.dart';
import '../repositories/prestamo_repository.dart';

class RegistrarPrestamo {
  final PrestamoRepository prestamos;
  final LibroRepository libros;
  final DateTime Function() reloj;

  RegistrarPrestamo(this.prestamos, this.libros, {this.reloj = fechaDeHoy});

  //metodo ejecutar: valida las reglas de negocio antes de enviar el prestamo
  Future<Prestamo> ejecutar({
    required int estudianteId,
    required int libroId,
    required DateTime fechaPrestamo,
    required DateTime fechaDevolucion,
  }) async {
    _comprobar(ReglasPrestamo.validarFechas(fechaPrestamo, fechaDevolucion));

    final delEstudiante = await prestamos.obtenerPrestamos(
      estudianteId: estudianteId,
    );
    _comprobar(ReglasPrestamo.validarEstudiante(delEstudiante, reloj()));

    //se consulta el libro otra vez para revisar el stock actual
    final libro = await libros.obtenerLibro(libroId);
    _comprobar(ReglasPrestamo.validarStock(libro));

    return prestamos.registrarPrestamo(
      Prestamo(
        id: null,
        estudianteId: estudianteId,
        libroId: libroId,
        fechaPrestamo: soloFecha(fechaPrestamo),
        fechaDevolucion: soloFecha(fechaDevolucion),
      ),
    );
  }

  void _comprobar(String? error) {
    if (error != null) throw ReglaNegocioException(error);
  }
}
