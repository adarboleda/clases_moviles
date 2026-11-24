import '../../domain/entities/reserva.dart';
import '../../domain/repositories/reserva_repository.dart';
import '../datasources/reserva_local_datasource.dart';
import '../models/reserva_model.dart';

class ReservaRepositoryImpl implements ReservaRepository {
  final ReservaLocalDatasource datasource;

  ReservaRepositoryImpl(this.datasource);

  @override
  Future<void> guardarReserva(Reserva reserva) =>
      datasource.guardar(ReservaModel.fromEntity(reserva));

  @override
  Future<Reserva?> obtenerUltimaReserva() => datasource.obtener();
}
