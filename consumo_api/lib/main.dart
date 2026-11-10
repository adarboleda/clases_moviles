import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/datasources/item_api.dart';
import 'data/repositories/item_repository_impl.dart';

import 'domain/usecases/obtener_items.dart';

import 'presentation/viewmodels/item_viewmodel.dart';
import 'presentation/views/inicio_view.dart';
import 'presentation/views/lista_view.dart';
import 'presentation/views/detalle_view.dart';

import 'routes/app_routes.dart';

void main() {
  final api = ItemApi();

  final repository =
  ItemRepositoryImpl(api);

  final useCase =
  ObtenerItems(repository);

  runApp(
    ChangeNotifierProvider(
      create: (_) =>
          ItemViewModel(obtenerItems: useCase),

      child: const MiApp(),
    ),
  );
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute:
      AppRoutes.inicio,

      routes: {
        AppRoutes.inicio:
            (_) => const InicioView(),

        AppRoutes.lista:
            (_) => const ListaView(),

        AppRoutes.detalle:
            (_) => const DetalleView(),
      },
    );
  }
}