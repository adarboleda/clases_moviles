import '../entities/reserva.dart';

abstract class ReservaRepository {
  Future<void> guardarReserva(Reserva reserva);
  Future<Reserva?> obtenerUltimaReserva();
}
