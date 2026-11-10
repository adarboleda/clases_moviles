import 'package:flutter/material.dart';

import '../../domain/entities/item.dart';
import '../../domain/usecases/obtener_items.dart';

class ItemViewModel extends ChangeNotifier {
  final ObtenerItems obtenerItems;

  ItemViewModel({required this.obtenerItems});

  List<Item> items = [];
  bool cargando = false;
  String error = '';

  //metodo
  Future<void> cargarItems() async {
    cargando = true;
    error = '';
    notifyListeners();

    try {
      items = await obtenerItems.ejecutar();
      error = '';
    } catch (e) {
      error = 'Error al cargar los items: $e';
    } finally {
      cargando = false;
      notifyListeners();
    }
  }
}
