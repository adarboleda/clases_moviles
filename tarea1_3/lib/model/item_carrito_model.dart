import 'producto_model.dart';

class ItemCarritoModel {
  final ProductoModel producto;
  int cantidad;

  ItemCarritoModel({required this.producto, this.cantidad = 1});

  double get subtotal => producto.precio * cantidad;
}
