import 'package:flutter/material.dart';

import '../model/categoria_model.dart';
import '../model/entrega_model.dart';
import '../model/item_carrito_model.dart';
import '../model/producto_model.dart';

class PedidoViewModel extends ChangeNotifier {
  static const int cantidadMaxima = 20;

  CategoriaModel categoriaSeleccionada = CategoriaModel.platos;
  EntregaModel entrega = EntregaModel.local;

  //carrito: id del producto -> producto con su cantidad
  final Map<String, ItemCarritoModel> _carrito = {};

  //---------- categorias ----------

  List<ProductoModel> get productos => ProductoModel.catalogo
      .where((producto) => producto.categoria == categoriaSeleccionada)
      .toList();

  void seleccionarCategoria(CategoriaModel categoria) {
    if (categoria == categoriaSeleccionada) return;
    categoriaSeleccionada = categoria;
    notifyListeners();
  }

  //devuelve false si ya se esta en la ultima categoria
  bool siguienteCategoria() {
    final indice = categoriaSeleccionada.index;
    if (indice == CategoriaModel.values.length - 1) return false;
    seleccionarCategoria(CategoriaModel.values[indice + 1]);
    return true;
  }

  //devuelve false si ya se esta en la primera categoria
  bool categoriaAnterior() {
    final indice = categoriaSeleccionada.index;
    if (indice == 0) return false;
    seleccionarCategoria(CategoriaModel.values[indice - 1]);
    return true;
  }

  //---------- carrito y cantidades ----------

  List<ItemCarritoModel> get items => _carrito.values.toList();
  bool get carritoVacio => _carrito.isEmpty;

  int cantidadDe(ProductoModel producto) =>
      _carrito[producto.id]?.cantidad ?? 0;

  int get totalArticulos =>
      _carrito.values.fold(0, (suma, item) => suma + item.cantidad);

  //devuelve false si el producto ya llego a la cantidad maxima
  bool agregar(ProductoModel producto) {
    final item = _carrito[producto.id];
    if (item == null) {
      _carrito[producto.id] = ItemCarritoModel(producto: producto);
    } else if (item.cantidad < cantidadMaxima) {
      item.cantidad++;
    } else {
      return false;
    }
    notifyListeners();
    return true;
  }

  void disminuir(ProductoModel producto) {
    final item = _carrito[producto.id];
    if (item == null) return;
    if (item.cantidad > 1) {
      item.cantidad--;
    } else {
      _carrito.remove(producto.id);
    }
    notifyListeners();
  }

  void cambiarEntrega(EntregaModel? nuevaEntrega) {
    if (nuevaEntrega == null) return;
    entrega = nuevaEntrega;
    notifyListeners();
  }

  void vaciar() {
    _carrito.clear();
    entrega = EntregaModel.local;
    notifyListeners();
  }

  //---------- total de compra ----------

  double get subtotal =>
      _carrito.values.fold(0.0, (suma, item) => suma + item.subtotal);

  double get costoEntrega => carritoVacio ? 0.0 : entrega.costo;

  double get total => subtotal + costoEntrega;

  //---------- validaciones ----------

  String? validarCliente(String texto) {
    final nombre = texto.trim();
    if (nombre.isEmpty) return 'Ingrese el nombre del cliente';
    if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ ]+$').hasMatch(nombre)) {
      return 'Solo se permiten letras y espacios';
    }
    if (nombre.length < 3) return 'El nombre es demasiado corto';
    return null;
  }
}
