import 'package:flutter/material.dart';

import '../../domain/entities/pelicula.dart';
import '../../domain/entities/reserva.dart';
import '../../domain/usecases/guardar_reserva.dart';
import '../../domain/usecases/obtener_ultima_reserva.dart';

class ReservaViewModel extends ChangeNotifier {
  final GuardarReserva _guardarReserva;
  final ObtenerUltimaReserva _obtenerUltimaReserva;

  ReservaViewModel(this._guardarReserva, this._obtenerUltimaReserva);

  // Selección en curso (pantalla de reserva)
  Pelicula? _pelicula;
  DateTime? _fecha;
  TimeOfDay? _hora;

  // Última reserva persistida
  Reserva? _ultimaReserva;

  Pelicula? get pelicula => _pelicula;
  DateTime? get fecha => _fecha;
  TimeOfDay? get hora => _hora;
  Reserva? get ultimaReserva => _ultimaReserva;
  bool get puedeGuardar => _pelicula != null && _fecha != null && _hora != null;

  /// Se llama al abrir la pantalla de reserva con la película recibida.
  void iniciarReserva(Pelicula pelicula) {
    _pelicula = pelicula;
    _fecha = null;
    _hora = null;
  }

  void seleccionarFecha(DateTime fecha) {
    _fecha = fecha;
    notifyListeners();
  }

  void seleccionarHora(TimeOfDay hora) {
    _hora = hora;
    notifyListeners();
  }

  Future<void> cargarUltimaReserva() async {
    _ultimaReserva = await _obtenerUltimaReserva();
    notifyListeners();
  }

  Future<bool> guardar() async {
    if (!puedeGuardar) return false;
    final h = _hora!;
    final reserva = Reserva(
      pelicula: _pelicula!.titulo,
      fecha: _fecha!,
      hora:
          '${h.hour.toString().padLeft(2, '0')}:${h.minute.toString().padLeft(2, '0')}',
    );
    await _guardarReserva(reserva);
    _ultimaReserva = reserva;
    notifyListeners();
    return true;
  }
}
