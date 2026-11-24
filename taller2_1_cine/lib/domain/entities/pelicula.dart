/// Entidad de dominio: una película de la cartelera.
class Pelicula {
  /// imdbID cuando viene de la API (ej. "tt3896198").
  final String id;
  final String titulo;
  final String genero;
  final String clasificacion;
  final String duracion;
  final String anio;
  final String sinopsis;

  /// URL del póster real (OMDb). Null si no hay póster o se usan datos locales.
  final String? posterUrl;

  /// Respaldo visual cuando no hay póster: emoji + degradado.
  final String emoji;
  final int colorInicio;
  final int colorFin;

  const Pelicula({
    required this.id,
    required this.titulo,
    required this.genero,
    required this.clasificacion,
    required this.duracion,
    required this.emoji,
    required this.colorInicio,
    required this.colorFin,
    this.anio = '',
    this.sinopsis = '',
    this.posterUrl,
  });
}
