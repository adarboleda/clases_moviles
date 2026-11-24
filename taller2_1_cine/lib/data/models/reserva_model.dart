import '../../domain/entities/reserva.dart';

class ReservaModel extends Reserva {
  const ReservaModel({
    required super.pelicula,
    required super.fecha,
    required super.hora,
  });

  factory ReservaModel.fromEntity(Reserva r) =>
      ReservaModel(pelicula: r.pelicula, fecha: r.fecha, hora: r.hora);
}
