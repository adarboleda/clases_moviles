import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/producto_model.dart';

class ProductoApi {
  final String url = 'https://dummyjson.com/products';

  //metodos para obtener producto
  Future<List<ProductoModel>> obtenerProductos() async {
    final respuesta = await http.get(Uri.parse('$url?limit=20'));
    if (respuesta.statusCode == 200) {
      final datos = jsonDecode(respuesta.body);
      final lista = datos['products'] as List;

      return lista.map((item) => ProductoModel.fromJson(item)).toList();
    } else {
      throw Exception('Error al cargar productos');
    }
  }

  //metodos para crear producto
  Future<ProductoModel> crearProductos(ProductoModel producto) async {
    final respuesta = await http.post(
      Uri.parse('$url/add'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(producto),
    );

    if (respuesta.statusCode == 200) {
      return ProductoModel.fromJson(jsonDecode(respuesta.body));
    } else {
      throw Exception('Error al crear producto');
    }
  }

  //metodo para actualizar producto
  Future<ProductoModel> actualizarProducto(ProductoModel producto) async {
    final respuesta = await http.put(
      Uri.parse('$url/${producto.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(producto),
    );

    if (respuesta.statusCode == 200) {
      return ProductoModel.fromJson(jsonDecode(respuesta.body));
    } else {
      throw Exception('Error al actualizar producto');
    }
  }

  //Metodo para eliminar producto
  Future<void> eliminarProducto(int id) async {
    final respuesta = await http.delete(
      Uri.parse('$url/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (respuesta.statusCode != 200) {
      throw Exception('Error al eliminar producto');
    }
  }
}
