import 'package:tarea2_2_biblioteca/domain/entities/estudiante.dart';
import 'package:tarea2_2_biblioteca/domain/entities/libro.dart';
import 'package:tarea2_2_biblioteca/domain/entities/prestamo.dart';
import 'package:tarea2_2_biblioteca/domain/errores/biblioteca_exception.dart';
import 'package:tarea2_2_biblioteca/domain/repositories/estudiante_repository.dart';
import 'package:tarea2_2_biblioteca/domain/repositories/libro_repository.dart';
import 'package:tarea2_2_biblioteca/domain/repositories/prestamo_repository.dart';

final hoy = DateTime.utc(2026, 11, 12);
DateTime dia(int desplazamiento) => hoy.add(Duration(days: desplazamiento));

Libro libro(int id, String titulo, int disponible, int total) => Libro(
  id: id,
  titulo: titulo,
  autor: 'Autor $id',
  categoria: id == 3 ? 'Literatura' : 'Ingeniería de software',
  anio: 2000 + id,
  paginas: 100 * id,
  descripcion: 'Descripción de $titulo',
  stockTotal: total,
  stockDisponible: disponible,
  portadaUrl: '',
);

//repositorio en memoria que imita a la API, incluido el manejo del stock
class RepositorioFalso
    implements LibroRepository, EstudianteRepository, PrestamoRepository {
  final libros = <Libro>[
    libro(1, 'Clean Code', 2, 2),
    libro(2, 'Rayuela', 0, 1),
    libro(3, 'Huasipungo', 3, 3),
  ];

  final estudiantes = <Estudiante>[
    Estudiante(
      id: 1,
      cedula: '1726354890',
      nombre: 'Ana Torres',
      carrera: 'Software',
      correo: 'ana@uni.edu.ec',
    ),
    Estudiante(
      id: 2,
      cedula: '1712345678',
      nombre: 'Luis Pérez',
      carrera: 'Sistemas',
      correo: 'luis@uni.edu.ec',
    ),
    Estudiante(
      id: 3,
      cedula: '1755512345',
      nombre: 'Carlos Ruiz',
      carrera: 'Civil',
      correo: 'carlos@uni.edu.ec',
    ),
  ];

  late final prestamos = <Prestamo>[
    //Ana: 3 activos
    _prestamo(1, 1, 3, dia(-2), dia(5)),
    _prestamo(2, 1, 3, dia(-1), dia(6)),
    _prestamo(3, 1, 3, dia(-3), dia(4)),
    //Luis: 1 vencido
    _prestamo(4, 2, 3, dia(-10), dia(-3)),
  ];

  int registrados = 0;

  Prestamo _prestamo(
    int id,
    int estudianteId,
    int libroId,
    DateTime fechaPrestamo,
    DateTime fechaDevolucion, {
    EstadoPrestamo estado = EstadoPrestamo.activo,
    DateTime? fechaEntrega,
  }) {
    return Prestamo(
      id: id,
      estudianteId: estudianteId,
      libroId: libroId,
      fechaPrestamo: fechaPrestamo,
      fechaDevolucion: fechaDevolucion,
      estado: estado,
      fechaEntrega: fechaEntrega,
      estudianteNombre: estudiantes
          .firstWhere((e) => e.id == estudianteId)
          .nombre,
      libroTitulo: libros.firstWhere((l) => l.id == libroId).titulo,
    );
  }

  void _cambiarStock(int libroId, int cambio) {
    final i = libros.indexWhere((l) => l.id == libroId);
    final l = libros[i];
    libros[i] = libro(l.id, l.titulo, l.stockDisponible + cambio, l.stockTotal);
  }

  @override
  Future<List<Libro>> obtenerLibros({bool soloDisponibles = false}) async =>
      libros.where((l) => !soloDisponibles || l.disponible).toList();

  @override
  Future<Libro> obtenerLibro(int id) async =>
      libros.firstWhere((l) => l.id == id);

  @override
  Future<List<Estudiante>> obtenerEstudiantes() async => List.of(estudiantes);

  @override
  Future<Estudiante> registrarEstudiante(Estudiante estudiante) async {
    final nuevo = Estudiante(
      id: estudiantes.length + 1,
      cedula: estudiante.cedula,
      nombre: estudiante.nombre,
      carrera: estudiante.carrera,
      correo: estudiante.correo,
    );
    estudiantes.add(nuevo);
    return nuevo;
  }

  @override
  Future<List<Prestamo>> obtenerPrestamos({int? estudianteId}) async =>
      prestamos
          .where((p) => estudianteId == null || p.estudianteId == estudianteId)
          .toList();

  @override
  Future<Prestamo> registrarPrestamo(Prestamo prestamo) async {
    registrados++;
    final nuevo = _prestamo(
      prestamos.length + 1,
      prestamo.estudianteId,
      prestamo.libroId,
      prestamo.fechaPrestamo,
      prestamo.fechaDevolucion,
    );
    prestamos.add(nuevo);
    _cambiarStock(prestamo.libroId, -1);
    return nuevo;
  }

  @override
  Future<Prestamo> registrarDevolucion(int id) async {
    final i = prestamos.indexWhere((p) => p.id == id);
    final p = prestamos[i];
    if (!p.activo) {
      throw const ReglaNegocioException(
        'Un préstamo devuelto no puede volver a estado activo',
      );
    }
    prestamos[i] = _prestamo(
      p.id!,
      p.estudianteId,
      p.libroId,
      p.fechaPrestamo,
      p.fechaDevolucion,
      estado: EstadoPrestamo.devuelto,
      fechaEntrega: hoy,
    );
    _cambiarStock(p.libroId, 1);
    return prestamos[i];
  }
}
