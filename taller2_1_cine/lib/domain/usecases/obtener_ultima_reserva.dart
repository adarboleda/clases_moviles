import '../entities/reserva.dart';
import '../repositories/reserva_repository.dart';

class ObtenerUltimaReserva {
  final ReservaRepository repository;

  ObtenerUltimaReserva(this.repository);

  Future<Reserva?> call() => repository.obtenerUltimaReserva();
}
