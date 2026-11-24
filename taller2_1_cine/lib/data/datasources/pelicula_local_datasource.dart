import '../models/pelicula_model.dart';

/// Cartelera local de respaldo (cuando no hay conexión a la API).
class PeliculaLocalDatasource {
  Future<List<PeliculaModel>> obtenerCartelera() async {
    const datos = <Map<String, dynamic>>[
      {
        'id': 1,
        'titulo': 'Aventura Espacial',
        'genero': 'Ciencia ficción',
        'clasificacion': '+12 AÑOS',
        'duracion': '2h 15min',
        'emoji': '🚀',
        'colorInicio': 0xFF1B2A6B,
        'colorFin': 0xFF6A1B9A,
      },
      {
        'id': 2,
        'titulo': 'Misterio Nocturno',
        'genero': 'Suspenso',
        'clasificacion': '+15 AÑOS',
        'duracion': '1h 55min',
        'emoji': '🕵️',
        'colorInicio': 0xFF0F2027,
        'colorFin': 0xFF2C5364,
      },
      {
        'id': 3,
        'titulo': 'Comedia en Familia',
        'genero': 'Comedia',
        'clasificacion': 'TODO PÚBLICO',
        'duracion': '1h 40min',
        'emoji': '😂',
        'colorInicio': 0xFFF57F17,
        'colorFin': 0xFFE65100,
      },
      {
        'id': 4,
        'titulo': 'Acción Total',
        'genero': 'Acción',
        'clasificacion': '+12 AÑOS',
        'duracion': '2h 05min',
        'emoji': '💥',
        'colorInicio': 0xFFB71C1C,
        'colorFin': 0xFF4A0E0E,
      },
      {
        'id': 5,
        'titulo': 'Mundo Fantástico',
        'genero': 'Fantasía',
        'clasificacion': 'TODO PÚBLICO',
        'duracion': '2h 20min',
        'emoji': '🐉',
        'colorInicio': 0xFF00695C,
        'colorFin': 0xFF1B5E20,
      },
      {
        'id': 6,
        'titulo': 'Viaje al Futuro',
        'genero': 'Ciencia ficción',
        'clasificacion': '+12 AÑOS',
        'duracion': '2h 30min',
        'emoji': '⏳',
        'colorInicio': 0xFF006064,
        'colorFin': 0xFF283593,
      },
    ];
    return datos.map(PeliculaModel.fromMap).toList();
  }
}
