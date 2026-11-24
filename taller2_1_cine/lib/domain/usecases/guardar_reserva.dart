import '../entities/reserva.dart';
import '../repositories/reserva_repository.dart';

class GuardarReserva {
  final ReservaRepository repository;

  GuardarReserva(this.repository);

  Future<void> call(Reserva reserva) => repository.guardarReserva(reserva);
}
