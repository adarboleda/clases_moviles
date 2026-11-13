import '../../core/fechas.dart';
import '../entities/libro.dart';
import '../entities/prestamo.dart';

//reglas de negocio de los prestamos
//cada metodo devuelve el mensaje de la regla que no se cumple, o null si todo es valido
class ReglasPrestamo {
  static const int maximoActivos = 3;
  static const int maximoDias = 7;

  static String? validarFechas(
    DateTime fechaPrestamo,
    DateTime fechaDevolucion,
  ) {
    final dias = diasEntre(fechaPrestamo, fechaDevolucion);
    if (dias <= 0) {
      return 'La fecha de devolución debe ser posterior a la fecha de préstamo';
    }
    if (dias > maximoDias) {
      return 'La duración máxima de un préstamo es de $maximoDias días';
    }
    return null;
  }

  //recibe todos los prestamos del estudiante
  static String? validarEstudiante(List<Prestamo> prestamos, DateTime hoy) {
    if (prestamos.any((prestamo) => prestamo.estaVencido(hoy))) {
      return 'El estudiante tiene un préstamo vencido y no puede solicitar otro libro';
    }
    final activos = prestamos.where((prestamo) => prestamo.activo).length;
    if (activos >= maximoActivos) {
      return 'El estudiante ya tiene $maximoActivos préstamos activos';
    }
    return null;
  }

  static String? validarStock(Libro libro) {
    if (!libro.disponible) return 'El libro no tiene stock disponible';
    return null;
  }

  //un prestamo devuelto no puede volver a cambiar de estado
  static String? validarDevolucion(Prestamo prestamo) {
    if (!prestamo.activo) {
      return 'El préstamo ya fue devuelto y no puede volver a estado activo';
    }
    return null;
  }
}
