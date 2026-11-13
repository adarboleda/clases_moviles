import '../../core/fechas.dart';
import '../../domain/entities/prestamo.dart';

class PrestamoModel extends Prestamo {
  PrestamoModel({
    required super.id,
    required super.estudianteId,
    required super.libroId,
    required super.fechaPrestamo,
    required super.fechaDevolucion,
    super.estado,
    super.fechaEntrega,
    super.estudianteNombre,
    super.libroTitulo,
    super.libroPortadaUrl,
  });

  factory PrestamoModel.desdeEntidad(Prestamo prestamo) {
    return PrestamoModel(
      id: prestamo.id,
      estudianteId: prestamo.estudianteId,
      libroId: prestamo.libroId,
      fechaPrestamo: prestamo.fechaPrestamo,
      fechaDevolucion: prestamo.fechaDevolucion,
      estado: prestamo.estado,
      fechaEntrega: prestamo.fechaEntrega,
    );
  }

  //metodo factory
  factory PrestamoModel.fromJson(
    Map<String, dynamic> json, {
    String Function(String ruta)? urlCompleta,
  }) {
    final portada = json['libroPortada'] as String? ?? '';
    final entrega = json['fechaEntrega'] as String?;
    return PrestamoModel(
      id: json['id'],
      estudianteId: json['estudianteId'],
      libroId: json['libroId'],
      fechaPrestamo: desdeIso(json['fechaPrestamo']),
      fechaDevolucion: desdeIso(json['fechaDevolucion']),
      estado: json['estado'] == 'devuelto'
          ? EstadoPrestamo.devuelto
          : EstadoPrestamo.activo,
      fechaEntrega: entrega == null ? null : desdeIso(entrega),
      estudianteNombre: json['estudianteNombre'] ?? '',
      libroTitulo: json['libroTitulo'] ?? '',
      libroPortadaUrl: urlCompleta?.call(portada) ?? portada,
    );
  }

  //solo se envian los datos necesarios para registrar el prestamo
  Map<String, dynamic> toJson() {
    return {
      'estudianteId': estudianteId,
      'libroId': libroId,
      'fechaPrestamo': aIso(fechaPrestamo),
      'fechaDevolucion': aIso(fechaDevolucion),
    };
  }
}
