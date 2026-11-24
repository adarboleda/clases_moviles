import 'package:flutter/material.dart';

import '../models/foto.dart';

class FotoProvider with ChangeNotifier {
  //arreglo
  final List<Foto> _fotos = [];

  List<Foto> get fotos => _fotos;

  void agregarFoto(Foto foto) {
    _fotos.add(foto);
    notifyListeners();
  }
}
