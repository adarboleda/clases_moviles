import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:taller2_1_cine/data/datasources/pelicula_local_datasource.dart';
import 'package:taller2_1_cine/data/datasources/pelicula_remote_datasource.dart';
import 'package:taller2_1_cine/data/datasources/reserva_local_datasource.dart';
import 'package:taller2_1_cine/data/models/pelicula_model.dart';
import 'package:taller2_1_cine/data/repositories/pelicula_repository_impl.dart';
import 'package:taller2_1_cine/data/repositories/reserva_repository_impl.dart';
import 'package:taller2_1_cine/domain/entities/pelicula.dart';
import 'package:taller2_1_cine/domain/entities/reserva.dart';
import 'package:taller2_1_cine/presentation/views/procesando_view.dart';
import 'package:taller2_1_cine/domain/usecases/guardar_reserva.dart';
import 'package:taller2_1_cine/domain/usecases/obtener_peliculas.dart';
import 'package:taller2_1_cine/domain/usecases/obtener_ultima_reserva.dart';
import 'package:taller2_1_cine/main.dart';
import 'package:taller2_1_cine/presentation/viewmodels/pelicula_viewmodel.dart';
import 'package:taller2_1_cine/presentation/viewmodels/reserva_viewmodel.dart';

void main() {
  testWidgets('Cartelera muestra el grid y navega a la reserva', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(tester.view.reset);
    SharedPreferences.setMockInitialValues({});

    // En test no hay red: el repositorio cae a la cartelera local.
    final peliculaRepo = PeliculaRepositoryImpl(
      PeliculaRemoteDatasource(),
      PeliculaLocalDatasource(),
    );
    final reservaRepo = ReservaRepositoryImpl(ReservaLocalDatasource());

    await tester.pumpWidget(
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
    await tester.pumpAndSettle();

    expect(find.text('Inicio'), findsOneWidget);
    expect(find.text('Boletos'), findsOneWidget);
    expect(find.text('Avisos'), findsOneWidget);
    expect(find.text('Perfil'), findsOneWidget);
    expect(find.text('AVENTURA ESPACIAL'), findsOneWidget);

    await tester.tap(find.text('AVENTURA ESPACIAL'));
    await tester.pumpAndSettle();

    expect(find.text('Reserva de boletos'), findsOneWidget);
    expect(find.text('Guardar reserva'), findsOneWidget);
  });

  testWidgets('Procesando compra: avanza, guarda la reserva y vuelve', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final reservaRepo = ReservaRepositoryImpl(ReservaLocalDatasource());
    final vm = ReservaViewModel(
      GuardarReserva(reservaRepo),
      ObtenerUltimaReserva(reservaRepo),
    );
    const pelicula = Pelicula(
      id: 'tt1',
      titulo: 'Dune',
      genero: 'Aventura',
      clasificacion: '+12 AÑOS',
      duracion: '2h 35min',
      emoji: '🏜️',
      colorInicio: 0xFF000000,
      colorFin: 0xFF111111,
    );
    vm.iniciarReserva(pelicula);
    vm.seleccionarFecha(DateTime(2026, 12, 10));
    vm.seleccionarHora(const TimeOfDay(hour: 18, minute: 0));

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: vm,
        child: MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProcesandoView()),
                ),
                child: const Text('comprar'),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('comprar'));
    await tester.pump(); // inicia la transición
    await tester.pump(const Duration(milliseconds: 500)); // ~14 %
    expect(find.text('Procesando compra'), findsOneWidget);
    expect(find.text('Verificando datos...'), findsOneWidget);
    expect(find.text('0%'), findsNothing); // ya avanzó

    await tester.pump(const Duration(seconds: 2)); // ~71 %
    expect(find.text('Registrando compra...'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2)); // llega a 100 % y guarda
    await tester.pump();
    expect(find.text('¡Compra registrada!'), findsOneWidget);
    expect(vm.ultimaReserva?.pelicula, 'Dune');
    expect(vm.ultimaReserva?.hora, '18:00');

    await tester.pump(const Duration(seconds: 2)); // vuelve a la pantalla previa
    await tester.pumpAndSettle();
    expect(find.text('Procesando compra'), findsNothing);
    expect(find.text('comprar'), findsOneWidget);
  });

  test('Parsea una respuesta real de OMDb', () {
    final p = PeliculaModel.fromOmdb({
      'Title': 'Guardians of the Galaxy: Vol. 2',
      'Year': '2017',
      'Rated': 'PG-13',
      'Runtime': '136 min',
      'Genre': 'Action, Adventure, Comedy',
      'Plot': 'The Guardians struggle to keep together.',
      'Poster': 'https://m.media-amazon.com/images/M/x.jpg',
      'imdbID': 'tt3896198',
    });
    expect(p.titulo, 'Guardians of the Galaxy: Vol. 2');
    expect(p.duracion, '2h 16min');
    expect(p.clasificacion, '+12 AÑOS');
    expect(p.genero, 'Acción · Aventura');
    expect(p.posterUrl, isNotNull);

    final sinPoster = PeliculaModel.fromOmdb({
      'Title': 'X',
      'Poster': 'N/A',
      'imdbID': 'tt1',
    });
    expect(sinPoster.posterUrl, isNull);
  });

  test('La última reserva (película, fecha y hora) se persiste', () async {
    SharedPreferences.setMockInitialValues({});
    final repo = ReservaRepositoryImpl(ReservaLocalDatasource());

    await GuardarReserva(repo)(
      Reserva(pelicula: 'Dune', fecha: DateTime(2026, 12, 10), hora: '18:00'),
    );

    final ultima = await ObtenerUltimaReserva(repo)();
    expect(ultima!.pelicula, 'Dune');
    expect(ultima.fecha, DateTime(2026, 12, 10));
    expect(ultima.hora, '18:00');
  });
}
