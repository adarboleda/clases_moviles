import 'package:flutter/material.dart';

import '../../domain/entities/libro.dart';
import '../../domain/errores/biblioteca_exception.dart';
import '../../domain/usecases/obtener_libros.dart';

class LibroViewModel extends ChangeNotifier {
  final ObtenerLibros obtener;

  LibroViewModel(this.obtener);

  List<Libro> libros = [];
  bool cargando = false;
  String error = '';

  //filtros del catalogo
  String busqueda = '';
  String? categoria;
  bool soloDisponibles = false;

  Future<void> cargar() async {
    cargando = true;
    notifyListeners();

    try {
      libros = await obtener.ejecutar();
      error = '';
    } on BibliotecaException catch (e) {
      error = e.mensaje;
    } catch (_) {
      error = 'Error al cargar los libros';
    }

    cargando = false;
    notifyListeners();
  }

  List<String> get categorias =>
      libros.map((libro) => libro.categoria).toSet().toList()..sort();

  List<Libro> get disponibles =>
      librosFiltrados.where((libro) => libro.disponible).toList();

  List<Libro> get librosFiltrados {
    final texto = busqueda.trim().toLowerCase();
    return libros.where((libro) {
      final coincide =
          texto.isEmpty ||
          libro.titulo.toLowerCase().contains(texto) ||
          libro.autor.toLowerCase().contains(texto);
      final enCategoria = categoria == null || libro.categoria == categoria;
      final conStock = !soloDisponibles || libro.disponible;
      return coincide && enCategoria && conStock;
    }).toList();
  }

  Libro? libroPorId(int id) {
    for (final libro in libros) {
      if (libro.id == id) return libro;
    }
    return null;
  }

  void buscar(String texto) {
    busqueda = texto;
    notifyListeners();
  }

  void seleccionarCategoria(String? nuevaCategoria) {
    categoria = nuevaCategoria;
    notifyListeners();
  }

  void cambiarSoloDisponibles(bool valor) {
    soloDisponibles = valor;
    notifyListeners();
  }
}
