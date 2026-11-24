import 'package:shared_preferences/shared_preferences.dart';

import '../models/reserva_model.dart';

/// Persistencia local de la última reserva con SharedPreferences.
class ReservaLocalDatasource {
  static const _kPelicula = 'ultima_reserva_pelicula';
  static const _kFecha = 'ultima_reserva_fecha';
  static const _kHora = 'ultima_reserva_hora';

  Future<void> guardar(ReservaModel reserva) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kPelicula, reserva.pelicula);
    await prefs.setString(_kFecha, reserva.fecha.toIso8601String());
    await prefs.setString(_kHora, reserva.hora);
  }

  Future<ReservaModel?> obtener() async {
    final prefs = await SharedPreferences.getInstance();
    final pelicula = prefs.getString(_kPelicula);
    final fecha = prefs.getString(_kFecha);
    final hora = prefs.getString(_kHora);
    if (pelicula == null || fecha == null || hora == null) return null;
    final fechaParseada = DateTime.tryParse(fecha);
    if (fechaParseada == null) return null;
    return ReservaModel(pelicula: pelicula, fecha: fechaParseada, hora: hora);
  }
}
