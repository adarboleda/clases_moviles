import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/estudiante_viewmodel.dart';
import '../viewmodels/libro_viewmodel.dart';
import '../viewmodels/prestamo_viewmodel.dart';

//vuelve a pedir a la API libros, estudiantes y prestamos
Future<void> recargarTodo(BuildContext context) {
  return Future.wait([
    context.read<LibroViewModel>().cargar(),
    context.read<EstudianteViewModel>().cargar(),
    context.read<PrestamoViewModel>().cargar(),
  ]);
}
