import '../../domain/entities/libro.dart';

class LibroModel extends Libro {
  LibroModel({
    required super.id,
    required super.titulo,
    required super.autor,
    required super.categoria,
    required super.anio,
    required super.paginas,
    required super.descripcion,
    required super.stockTotal,
    required super.stockDisponible,
    required super.portadaUrl,
  });

  //metodo factory; urlCompleta convierte la ruta de la portada en una URL
  factory LibroModel.fromJson(
    Map<String, dynamic> json, {
    String Function(String ruta)? urlCompleta,
  }) {
    final portada = json['portada'] as String? ?? '';
    return LibroModel(
      id: json['id'],
      titulo: json['titulo'] ?? '',
      autor: json['autor'] ?? '',
      categoria: json['categoria'] ?? '',
      anio: json['anio'] ?? 0,
      paginas: json['paginas'] ?? 0,
      descripcion: json['descripcion'] ?? '',
      stockTotal: json['stockTotal'] ?? 0,
      stockDisponible: json['stockDisponible'] ?? 0,
      portadaUrl: urlCompleta?.call(portada) ?? portada,
    );
  }
}
