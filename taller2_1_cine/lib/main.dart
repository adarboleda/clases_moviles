import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/datasources/pelicula_local_datasource.dart';
import 'data/datasources/pelicula_remote_datasource.dart';
import 'data/datasources/reserva_local_datasource.dart';
import 'data/repositories/pelicula_repository_impl.dart';
import 'data/repositories/reserva_repository_impl.dart';
import 'domain/usecases/guardar_reserva.dart';
import 'domain/usecases/obtener_peliculas.dart';
import 'domain/usecases/obtener_ultima_reserva.dart';
import 'presentation/theme/app_theme.dart';
import 'presentation/viewmodels/pelicula_viewmodel.dart';
import 'presentation/viewmodels/reserva_viewmodel.dart';
import 'routes/app_routes.dart';

void main() {
  // Inyección de dependencias manual: datasource -> repository -> usecase -> viewmodel
  final peliculaRepo = PeliculaRepositoryImpl(
    PeliculaRemoteDatasource(),
    PeliculaLocalDatasource(),
  );
  final reservaRepo = ReservaRepositoryImpl(ReservaLocalDatasource());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PeliculaViewModel(ObtenerPeliculas(peliculaRepo))
            ..cargarPeliculas(),
        ),
        ChangeNotifierProvider(
          create: (_) => ReservaViewModel(
            GuardarReserva(reservaRepo),
            ObtenerUltimaReserva(reservaRepo),
          )..cargarUltimaReserva(),
        ),
      ],
      child: const CineApp(),
    ),
  );
}

class CineApp extends StatelessWidget {
  const CineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cine App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      initialRoute: AppRoutes.inicio,
      routes: AppRoutes.routes,
    );
  }
}
