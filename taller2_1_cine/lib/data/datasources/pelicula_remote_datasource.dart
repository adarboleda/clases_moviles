import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/pelicula_model.dart';

/// Cartelera real consumida desde OMDb (https://www.omdbapi.com).
class PeliculaRemoteDatasource {
  static const _apiKey = 'cc23a71f';
  static const _host = 'www.omdbapi.com';

  /// IMDb IDs de las películas de la cartelera. Para mostrar otras, basta con
  /// agregar o cambiar IDs (se buscan en imdb.com o con `?s=titulo` en OMDb).
  static const _imdbIds = [
    'tt3896198', // Guardians of the Galaxy Vol. 2
    'tt1375666', // Inception
    'tt0816692', // Interstellar
    'tt1160419', // Dune
    'tt15398776', // Oppenheimer
    'tt9362722', // Spider-Man: Across the Spider-Verse
    'tt6791350', // Guardians of the Galaxy Vol. 3
    'tt1630029', // Avatar: The Way of Water
    'tt1877830', // The Batman
  ];

  final http.Client _client;

  PeliculaRemoteDatasource({http.Client? client})
      : _client = client ?? http.Client();

  Future<List<PeliculaModel>> obtenerCartelera() async {
    // Una petición por película, todas en paralelo.
    final resultados = await Future.wait(_imdbIds.map(_obtenerPorId));
    final peliculas = resultados.whereType<PeliculaModel>().toList();
    if (peliculas.isEmpty) {
      throw Exception('OMDb no devolvió ninguna película');
    }
    return peliculas;
  }

  Future<PeliculaModel?> _obtenerPorId(String imdbId) async {
    try {
      final uri = Uri.https(_host, '/', {'i': imdbId, 'apikey': _apiKey});
      final resp = await _client.get(uri).timeout(const Duration(seconds: 10));
      if (resp.statusCode != 200) return null;
      final json = jsonDecode(resp.body) as Map<String, dynamic>;
      if (json['Response'] != 'True') return null;
      return PeliculaModel.fromOmdb(json);
    } catch (_) {
      return null; // una película fallida no debe tumbar toda la cartelera
    }
  }
}
