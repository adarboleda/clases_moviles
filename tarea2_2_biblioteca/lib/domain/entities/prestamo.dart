import '../../core/fechas.dart';

//el estado vencido no se guarda: se calcula comparando la fecha de devolucion con hoy
enum EstadoPrestamo { activo, devuelto }

class Prestamo {
  final int? id;
  final int estudianteId;
  final int libroId;
  final DateTime fechaPrestamo;
  final DateTime fechaDevolucion;
  final EstadoPrestamo estado;
  final DateTime? fechaEntrega;

  //datos de solo lectura que envia la API para mostrar el prestamo
  final String estudianteNombre;
  final String libroTitulo;
  final String libroPortadaUrl;

  Prestamo({
    required this.id,
    required this.estudianteId,
    required this.libroId,
    required this.fechaPrestamo,
    required this.fechaDevolucion,
    this.estado = EstadoPrestamo.activo,
    this.fechaEntrega,
    this.estudianteNombre = '',
    this.libroTitulo = '',
    this.libroPortadaUrl = '',
  });

  bool get activo => estado == EstadoPrestamo.activo;

  int get duracionDias => diasEntre(fechaPrestamo, fechaDevolucion);

  //sigue activo y la fecha de devolucion ya paso
  bool estaVencido(DateTime hoy) =>
      activo && soloFecha(hoy).isAfter(fechaDevolucion);

  //negativo cuando el prestamo esta atrasado
  int diasRestantes(DateTime hoy) => diasEntre(hoy, fechaDevolucion);
}
