import 'package:flutter/material.dart';

import '../../core/fechas.dart';
import '../../domain/entities/prestamo.dart';
import '../../domain/errores/biblioteca_exception.dart';
import '../../domain/reglas/reglas_prestamo.dart';
import '../../domain/usecases/obtener_prestamos.dart';
import '../../domain/usecases/registrar_devolucion.dart';
import '../../domain/usecases/registrar_prestamo.dart';

//estado que se muestra en pantalla; vencido se calcula con la fecha de hoy
enum EstadoVisible { activo, vencido, devuelto }

enum FiltroPrestamo { activos, vencidos, devueltos, todos }

class PrestamoViewModel extends ChangeNotifier {
  final ObtenerPrestamos obtener;
  final RegistrarPrestamo registrarPrestamo;
  final RegistrarDevolucion registrarDevolucion;
  final DateTime Function() reloj;

  PrestamoViewModel(
    this.obtener,
    this.registrarPrestamo,
    this.registrarDevolucion, {
    this.reloj = fechaDeHoy,
  });

  List<Prestamo> prestamos = [];
  bool cargando = false;
  String error = '';
  FiltroPrestamo filtro = FiltroPrestamo.activos;

  DateTime get hoy => reloj();

  Future<void> cargar() async {
    cargando = true;
    notifyListeners();

    try {
      prestamos = await obtener.ejecutar();
      //primero los que deben devolverse antes
      prestamos.sort((a, b) => a.fechaDevolucion.compareTo(b.fechaDevolucion));
      error = '';
    } on BibliotecaException catch (e) {
      error = e.mensaje;
    } catch (_) {
      error = 'Error al cargar los préstamos';
    }

    cargando = false;
    notifyListeners();
  }

  EstadoVisible estadoDe(Prestamo prestamo) {
    if (!prestamo.activo) return EstadoVisible.devuelto;
    if (prestamo.estaVencido(hoy)) return EstadoVisible.vencido;
    return EstadoVisible.activo;
  }

  //activos incluye a los vencidos porque todavia no se devuelven
  List<Prestamo> get activos => prestamos.where((p) => p.activo).toList();

  List<Prestamo> get vencidos =>
      prestamos.where((p) => p.estaVencido(hoy)).toList();

  List<Prestamo> get devueltos => prestamos.where((p) => !p.activo).toList();

  List<Prestamo> get filtrados {
    switch (filtro) {
      case FiltroPrestamo.activos:
        return activos;
      case FiltroPrestamo.vencidos:
        return vencidos;
      case FiltroPrestamo.devueltos:
        return devueltos.reversed.toList();
      case FiltroPrestamo.todos:
        return prestamos;
    }
  }

  void cambiarFiltro(FiltroPrestamo nuevoFiltro) {
    filtro = nuevoFiltro;
    notifyListeners();
  }

  List<Prestamo> prestamosDe(int estudianteId) =>
      prestamos.where((p) => p.estudianteId == estudianteId).toList();

  int activosDe(int estudianteId) =>
      prestamosDe(estudianteId).where((p) => p.activo).length;

  //motivo por el que el estudiante no puede pedir otro libro, o null si puede
  String? motivoBloqueo(int estudianteId) =>
      ReglasPrestamo.validarEstudiante(prestamosDe(estudianteId), hoy);

  Prestamo? prestamoPorId(int id) {
    for (final prestamo in prestamos) {
      if (prestamo.id == id) return prestamo;
    }
    return null;
  }

  //lanzan BibliotecaException si no se cumple una regla de negocio
  Future<void> registrar({
    required int estudianteId,
    required int libroId,
    required DateTime fechaPrestamo,
    required DateTime fechaDevolucion,
  }) async {
    await registrarPrestamo.ejecutar(
      estudianteId: estudianteId,
      libroId: libroId,
      fechaPrestamo: fechaPrestamo,
      fechaDevolucion: fechaDevolucion,
    );
    await cargar();
  }

  Future<void> devolver(Prestamo prestamo) async {
    await registrarDevolucion.ejecutar(prestamo);
    await cargar();
  }
}
