import '../../domain/entities/item.dart';

class ItemModel extends Item {
  ItemModel({
    required super.id,
    required super.nombre,
    required super.especie,
    required super.genero,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      nombre: json['name'] ?? 'Sin nombre',
      especie: json['species'] ?? 'Desconocida',
      genero: json['gender'] ?? 'Desconocido',
    );
  }
}
