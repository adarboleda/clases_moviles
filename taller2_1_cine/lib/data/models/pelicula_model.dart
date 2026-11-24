import '../../domain/entities/pelicula.dart';

class PeliculaModel extends Pelicula {
  const PeliculaModel({
    required super.id,
    required super.titulo,
    required super.genero,
    required super.clasificacion,
    required super.duracion,
    required super.emoji,
    required super.colorInicio,
    required super.colorFin,
    super.anio,
    super.sinopsis,
    super.posterUrl,
  });

  /// Datos locales de respaldo (sin conexión).
  factory PeliculaModel.fromMap(Map<String, dynamic> map) => PeliculaModel(
        id: map['id'].toString(),
        titulo: map['titulo'] as String,
        genero: map['genero'] as String,
        clasificacion: map['clasificacion'] as String,
        duracion: map['duracion'] as String,
        emoji: map['emoji'] as String,
        colorInicio: map['colorInicio'] as int,
        colorFin: map['colorFin'] as int,
      );

  /// Respuesta JSON de OMDb (consulta por imdbID).
  factory PeliculaModel.fromOmdb(Map<String, dynamic> json) {
    final id = json['imdbID'] as String;
    final generos = _texto(json['Genre'])
        .split(',')
        .map((g) => g.trim())
        .where((g) => g.isNotEmpty)
        .toList();
    final colores = _paletas[id.hashCode.abs() % _paletas.length];
    final poster = _texto(json['Poster']);

    return PeliculaModel(
      id: id,
      titulo: _texto(json['Title']),
      genero: generos.take(2).map((g) => _generos[g] ?? g).join(' · '),
      clasificacion: _clasificacion(_texto(json['Rated'])),
      duracion: _duracion(_texto(json['Runtime'])),
      anio: _texto(json['Year']),
      sinopsis: _texto(json['Plot']),
      posterUrl: poster.isEmpty ? null : poster,
      emoji: generos.isEmpty ? '🎬' : (_emojis[generos.first] ?? '🎬'),
      colorInicio: colores[0],
      colorFin: colores[1],
    );
  }

  /// OMDb usa "N/A" para datos ausentes.
  static String _texto(dynamic v) {
    final s = (v as String?)?.trim() ?? '';
    return s == 'N/A' ? '' : s;
  }

  static String _clasificacion(String rated) {
    switch (rated) {
      case 'G':
        return 'TODO PÚBLICO';
      case 'PG':
        return '+7 AÑOS';
      case 'PG-13':
        return '+12 AÑOS';
      case 'R':
      case 'NC-17':
        return '+18 AÑOS';
      default:
        return 'SIN CLASIFICAR';
    }
  }

  /// "136 min" -> "2h 16min"
  static String _duracion(String runtime) {
    final minutos = int.tryParse(runtime.replaceAll(RegExp(r'[^0-9]'), ''));
    if (minutos == null) return '—';
    final h = minutos ~/ 60;
    final m = minutos % 60;
    return h == 0 ? '${m}min' : '${h}h ${m.toString().padLeft(2, '0')}min';
  }

  static const _generos = {
    'Action': 'Acción',
    'Adventure': 'Aventura',
    'Animation': 'Animación',
    'Biography': 'Biografía',
    'Comedy': 'Comedia',
    'Crime': 'Crimen',
    'Drama': 'Drama',
    'Family': 'Familia',
    'Fantasy': 'Fantasía',
    'History': 'Historia',
    'Horror': 'Terror',
    'Mystery': 'Misterio',
    'Romance': 'Romance',
    'Sci-Fi': 'Ciencia ficción',
    'Thriller': 'Suspenso',
  };

  static const _emojis = {
    'Action': '💥',
    'Adventure': '🧭',
    'Animation': '🎨',
    'Biography': '📖',
    'Comedy': '😂',
    'Crime': '🕵️',
    'Drama': '🎭',
    'Family': '👨‍👩‍👧',
    'Fantasy': '🐉',
    'History': '🏛️',
    'Horror': '👻',
    'Mystery': '🔎',
    'Romance': '❤️',
    'Sci-Fi': '🚀',
    'Thriller': '😱',
  };

  static const _paletas = [
    [0xFF1B2A6B, 0xFF6A1B9A],
    [0xFF0F2027, 0xFF2C5364],
    [0xFFB71C1C, 0xFF4A0E0E],
    [0xFF00695C, 0xFF1B5E20],
    [0xFF006064, 0xFF283593],
    [0xFFF57F17, 0xFFE65100],
  ];
}
