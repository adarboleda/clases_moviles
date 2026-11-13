import 'package:flutter/material.dart';

import '../../domain/entities/estudiante.dart';
import '../../domain/errores/biblioteca_exception.dart';
import '../../domain/usecases/obtener_estudiantes.dart';
import '../../domain/usecases/registrar_estudiante.dart';

class EstudianteViewModel extends ChangeNotifier {
  final ObtenerEstudiantes obtener;
  final RegistrarEstudiante registrarEstudiante;

  EstudianteViewModel(this.obtener, this.registrarEstudiante);

  List<Estudiante> estudiantes = [];
  bool cargando = false;
  String error = '';

  Future<void> cargar() async {
    cargando = true;
    notifyListeners();

    try {
      estudiantes = await obtener.ejecutar();
      estudiantes.sort((a, b) => a.nombre.compareTo(b.nombre));
      error = '';
    } on BibliotecaException catch (e) {
      error = e.mensaje;
    } catch (_) {
      error = 'Error al cargar los estudiantes';
    }

    cargando = false;
    notifyListeners();
  }

  //lanza BibliotecaException si no se cumple una validacion o falla la API
  Future<void> registrar(Estudiante estudiante) async {
    await registrarEstudiante.ejecutar(estudiante);
    await cargar();
  }

  Estudiante? estudiantePorId(int id) {
    for (final estudiante in estudiantes) {
      if (estudiante.id == id) return estudiante;
    }
    return null;
  }
}
