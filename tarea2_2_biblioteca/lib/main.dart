import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'core/fechas.dart';
import 'data/datasources/api_cliente.dart';
import 'data/datasources/estudiante_api.dart';
import 'data/datasources/libro_api.dart';
import 'data/datasources/prestamo_api.dart';
import 'data/repositories/estudiante_repository_impl.dart';
import 'data/repositories/libro_repository_impl.dart';
import 'data/repositories/prestamo_repository_impl.dart';

import 'domain/repositories/estudiante_repository.dart';
import 'domain/repositories/libro_repository.dart';
import 'domain/repositories/prestamo_repository.dart';
import 'domain/usecases/obtener_estudiantes.dart';
import 'domain/usecases/obtener_libros.dart';
import 'domain/usecases/obtener_prestamos.dart';
import 'domain/usecases/registrar_devolucion.dart';
import 'domain/usecases/registrar_estudiante.dart';
import 'domain/usecases/registrar_prestamo.dart';

import 'presentation/theme/app_tema.dart';
import 'presentation/viewmodels/estudiante_viewmodel.dart';
import 'presentation/viewmodels/libro_viewmodel.dart';
import 'presentation/viewmodels/prestamo_viewmodel.dart';
import 'presentation/views/catalogo_view.dart';
import 'presentation/views/detalle_estudiante_view.dart';
import 'presentation/views/detalle_libro_view.dart';
import 'presentation/views/detalle_prestamo_view.dart';
import 'presentation/views/formulario_estudiante_view.dart';
import 'presentation/views/formulario_prestamo_view.dart';
import 'presentation/views/inicio_view.dart';

import 'routes/app_routes.dart';

void main() {
  final cliente = ApiCliente();

  final libroRepository = LibroRepositoryImpl(api: LibroApi(cliente));
  final estudianteRepository = EstudianteRepositoryImpl(
    api: EstudianteApi(cliente),
  );
  final prestamoRepository = PrestamoRepositoryImpl(api: PrestamoApi(cliente));

  runApp(
    MultiProvider(
      providers: crearProveedores(
        libros: libroRepository,
        estudiantes: estudianteRepository,
        prestamos: prestamoRepository,
      ),
      child: const MiApp(),
    ),
  );
}

//crea los casos de uso y los view models a partir de los repositorios
//las pruebas lo usan con repositorios falsos
List<SingleChildWidget> crearProveedores({
  required LibroRepository libros,
  required EstudianteRepository estudiantes,
  required PrestamoRepository prestamos,
  DateTime Function() reloj = fechaDeHoy,
}) {
  return [
    ChangeNotifierProvider(
      create: (_) => LibroViewModel(ObtenerLibros(libros)),
    ),
    ChangeNotifierProvider(
      create: (_) => EstudianteViewModel(
        ObtenerEstudiantes(estudiantes),
        RegistrarEstudiante(estudiantes),
      ),
    ),
    ChangeNotifierProvider(
      create: (_) => PrestamoViewModel(
        ObtenerPrestamos(prestamos),
        RegistrarPrestamo(prestamos, libros, reloj: reloj),
        RegistrarDevolucion(prestamos),
        reloj: reloj,
      ),
    ),
  ];
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biblioteca universitaria',
      theme: AppTema.tema,
      initialRoute: AppRoutes.inicio,
      routes: {
        AppRoutes.inicio: (_) => const InicioView(),
        AppRoutes.catalogo: (_) => const CatalogoView(),
        AppRoutes.detalleLibro: (_) => const DetalleLibroView(),
        AppRoutes.nuevoPrestamo: (_) => const FormularioPrestamoView(),
        AppRoutes.detallePrestamo: (_) => const DetallePrestamoView(),
        AppRoutes.nuevoEstudiante: (_) => const FormularioEstudianteView(),
        AppRoutes.detalleEstudiante: (_) => const DetalleEstudianteView(),
      },
    );
  }
}
