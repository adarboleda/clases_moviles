import 'package:flutter/material.dart';

//categorias del menu en el orden en que se recorren al deslizar
enum CategoriaModel {
  platos('Platos', Icons.restaurant),
  bebidas('Bebidas', Icons.local_drink),
  postres('Postres', Icons.cake);

  final String nombre;
  final IconData icono;

  const CategoriaModel(this.nombre, this.icono);
}
