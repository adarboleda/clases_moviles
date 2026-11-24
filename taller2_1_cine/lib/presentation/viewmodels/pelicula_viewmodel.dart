import 'package:flutter/foundation.dart';

import '../../domain/entities/pelicula.dart';
import '../../domain/usecases/obtener_peliculas.dart';

class PeliculaViewModel extends ChangeNotifier {
  final ObtenerPeliculas _obtenerPeliculas;

  PeliculaViewModel(this._obtenerPeliculas);

  List<Pelicula> _peliculas = [];
  bool _cargando = false;

  List<Pelicula> get peliculas => _peliculas;
  bool get cargando => _cargando;

  Future<void> cargarPeliculas() async {
    _cargando = true;
    notifyListeners();
    _peliculas = await _obtenerPeliculas();
    _cargando = false;
    notifyListeners();
  }
}
