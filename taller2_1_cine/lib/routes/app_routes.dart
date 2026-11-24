import 'package:flutter/material.dart';

import '../domain/entities/pelicula.dart';
import '../presentation/views/inicio_view.dart';
import '../presentation/views/procesando_view.dart';
import '../presentation/views/reserva_view.dart';

class AppRoutes {
  static const inicio = '/';
  static const reserva = '/reserva';
  static const procesando = '/procesando';

  static Map<String, WidgetBuilder> get routes => {
        inicio: (_) => const InicioView(),
        procesando: (_) => const ProcesandoView(),
        // La película llega mediante `arguments`.
        reserva: (context) {
          final pelicula =
              ModalRoute.of(context)!.settings.arguments as Pelicula;
          return ReservaView(pelicula: pelicula);
        },
      };
}
