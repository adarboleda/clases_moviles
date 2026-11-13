import 'package:flutter_test/flutter_test.dart';

import 'package:tarea2_2_biblioteca/domain/entities/estudiante.dart';
import 'package:tarea2_2_biblioteca/domain/entities/prestamo.dart';
import 'package:tarea2_2_biblioteca/domain/errores/biblioteca_exception.dart';
import 'package:tarea2_2_biblioteca/domain/reglas/reglas_prestamo.dart';
import 'package:tarea2_2_biblioteca/domain/usecases/registrar_devolucion.dart';
import 'package:tarea2_2_biblioteca/domain/usecases/registrar_estudiante.dart';
import 'package:tarea2_2_biblioteca/domain/usecases/registrar_prestamo.dart';

import 'fakes.dart';

Matcher lanzaRegla(String texto) => throwsA(
  isA<ReglaNegocioException>().having(
    (e) => e.mensaje,
    'mensaje',
    contains(texto),
  ),
);

void main() {
  group('Reglas de fechas', () {
    test('la devolución debe ser posterior al préstamo', () {
      expect(ReglasPrestamo.validarFechas(hoy, hoy), contains('posterior'));
      expect(ReglasPrestamo.validarFechas(hoy, dia(-1)), contains('posterior'));
    });

    test('la duración máxima es de 7 días', () {
      expect(ReglasPrestamo.validarFechas(hoy, dia(7)), isNull);
      expect(ReglasPrestamo.validarFechas(hoy, dia(8)), contains('7 días'));
    });

    test('un préstamo que vence hoy todavía no está vencido', () {
      final prestamo = Prestamo(
        id: 1,
        estudianteId: 1,
        libroId: 1,
        fechaPrestamo: dia(-7),
        fechaDevolucion: hoy,
      );
      expect(prestamo.estaVencido(hoy), isFalse);
      expect(prestamo.estaVencido(dia(1)), isTrue);
      expect(prestamo.diasRestantes(dia(3)), -3);
    });
  });

  group('RegistrarPrestamo', () {
    late RepositorioFalso repo;
    late RegistrarPrestamo registrar;

    setUp(() {
      repo = RepositorioFalso();
      registrar = RegistrarPrestamo(repo, repo, reloj: () => hoy);
    });

    test('registra el préstamo y disminuye el stock en 1', () async {
      final prestamo = await registrar.ejecutar(
        estudianteId: 3,
        libroId: 1,
        fechaPrestamo: hoy,
        fechaDevolucion: dia(7),
      );
      expect(prestamo.activo, isTrue);
      expect((await repo.obtenerLibro(1)).stockDisponible, 1);
    });

    test('no permite más de 3 préstamos activos', () {
      expect(
        registrar.ejecutar(
          estudianteId: 1,
          libroId: 1,
          fechaPrestamo: hoy,
          fechaDevolucion: dia(3),
        ),
        lanzaRegla('3 préstamos activos'),
      );
    });

    test('no permite pedir libros con un préstamo vencido', () {
      expect(
        registrar.ejecutar(
          estudianteId: 2,
          libroId: 1,
          fechaPrestamo: hoy,
          fechaDevolucion: dia(3),
        ),
        lanzaRegla('vencido'),
      );
    });

    test('no permite prestar un libro sin stock', () {
      expect(
        registrar.ejecutar(
          estudianteId: 3,
          libroId: 2,
          fechaPrestamo: hoy,
          fechaDevolucion: dia(3),
        ),
        lanzaRegla('stock'),
      );
    });

    test('valida las fechas antes de llamar a la API', () async {
      await expectLater(
        registrar.ejecutar(
          estudianteId: 3,
          libroId: 1,
          fechaPrestamo: hoy,
          fechaDevolucion: dia(10),
        ),
        lanzaRegla('7 días'),
      );
      expect(repo.registrados, 0);
    });
  });

  group('RegistrarDevolucion', () {
    test('aumenta el stock y no permite volver a cambiar el estado', () async {
      final repo = RepositorioFalso();
      final devolver = RegistrarDevolucion(repo);
      final prestamo = (await repo.obtenerPrestamos(estudianteId: 2)).first;
      final stockAntes = (await repo.obtenerLibro(prestamo.libroId))
          .stockDisponible;

      final devuelto = await devolver.ejecutar(prestamo);
      expect(devuelto.estado, EstadoPrestamo.devuelto);
      expect(
        (await repo.obtenerLibro(prestamo.libroId)).stockDisponible,
        stockAntes + 1,
      );

      expect(() => devolver.ejecutar(devuelto), lanzaRegla('no puede volver'));
    });
  });

  group('RegistrarEstudiante', () {
    Estudiante estudiante({
      String cedula = '1700000001',
      String correo = 'a@b.ec',
    }) => Estudiante(
      id: null,
      cedula: cedula,
      nombre: 'Pedro Vega',
      carrera: 'Electrónica',
      correo: correo,
    );

    test('valida cédula y correo', () {
      final registrar = RegistrarEstudiante(RepositorioFalso());
      expect(
        () => registrar.ejecutar(estudiante(cedula: '123')),
        lanzaRegla('10 dígitos'),
      );
      expect(
        () => registrar.ejecutar(estudiante(correo: 'correo')),
        lanzaRegla('correo'),
      );
    });

    test('registra un estudiante válido', () async {
      final repo = RepositorioFalso();
      final nuevo = await RegistrarEstudiante(repo).ejecutar(estudiante());
      expect(nuevo.id, 4);
    });
  });
}
