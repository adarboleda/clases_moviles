class Libro {
  final int id;
  final String titulo;
  final String autor;
  final String categoria;
  final int anio;
  final int paginas;
  final String descripcion;
  final int stockTotal;
  final int stockDisponible;
  final String portadaUrl;

  Libro({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.categoria,
    required this.anio,
    required this.paginas,
    required this.descripcion,
    required this.stockTotal,
    required this.stockDisponible,
    required this.portadaUrl,
  });

  bool get disponible => stockDisponible > 0;
}
