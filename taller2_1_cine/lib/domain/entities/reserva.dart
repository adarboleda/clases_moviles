/// Entidad de dominio: reserva de una función de cine.
class Reserva {
  final String pelicula;
  final DateTime fecha;

  /// Hora en formato 24h "HH:mm".
  final String hora;

  const Reserva({
    required this.pelicula,
    required this.fecha,
    required this.hora,
  });
}
