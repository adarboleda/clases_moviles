import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/item_model.dart';

class ItemApi {
  //url de la API
  final String url = 'https://rickandmortyapi.com/api/character';

  Future<List<ItemModel>> obtenerItems() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final datos = jsonDecode(response.body);

      // La API devuelve { "info": {...}, "results": [...] }
      return (datos['results'] as List)
          .map((item) => ItemModel.fromJson(item))
          .toList();
    } else {
      throw Exception('Error al cargar los datos de la api');
    }
  }
}
