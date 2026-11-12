import '../../domain/entities/producto.dart';

class ProductoModel extends Producto {
  ProductoModel({
    required super.id,
    required super.nombre,
    required super.descripcion,
    required super.precio,
  });

  //metodo factory

  factory ProductoModel.fromJson(Map<String, dynamic> json) {
    return ProductoModel(
      id: json['id'],
      nombre: json['title'] ?? '',
      descripcion: json['description'] ?? '',
      precio: (json['price'] as num? ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': nombre, 'description':descripcion, 'price': precio};
  }
}
