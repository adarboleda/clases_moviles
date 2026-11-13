import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:tarea2_2_biblioteca/data/datasources/api_cliente.dart';
import 'package:tarea2_2_biblioteca/data/datasources/libro_api.dart';
import 'package:tarea2_2_biblioteca/data/datasources/prestamo_api.dart';
import 'package:tarea2_2_biblioteca/data/models/prestamo_model.dart';
import 'package:tarea2_2_biblioteca/domain/entities/prestamo.dart';
import 'package:tarea2_2_biblioteca/domain/errores/biblioteca_exception.dart';

const base = 'http://api.prueba';

http.Response json(Object cuerpo, [int codigo = 200]) => http.Response(
  jsonEncode(cuerpo),
  codigo,
  headers: {'content-type': 'application/json; charset=utf-8'},
);

void main() {
  test('LibroApi convierte el JSON y arma la URL de la portada', () async {
    final cliente = ApiCliente(
      baseUrl: base,
      cliente: MockClient((peticion) async {
        expect(peticion.url.toString(), '$base/libros?disponibles=true');
        return json([
          {
            'id': 8,
            'titulo': 'Huasipungo',
            'autor': 'Jorge Icaza',
            'categoria': 'Literatura',
            'anio': 1934,
            'paginas': 195,
            'descripcion': 'Novela',
            'stockTotal': 3,
            'stockDisponible': 2,
            'portada': '/portadas/huasipungo.jpg',
          },
        ]);
      }),
    );

    final libros = await LibroApi(cliente).obtenerLibros(soloDisponibles: true);
    expect(libros.single.titulo, 'Huasipungo');
    expect(libros.single.stockDisponible, 2);
    expect(libros.single.portadaUrl, '$base/portadas/huasipungo.jpg');
  });

  test('PrestamoApi envía las fechas en formato AAAA-MM-DD', () async {
    late Map<String, dynamic> enviado;
    final cliente = ApiCliente(
      baseUrl: base,
      cliente: MockClient((peticion) async {
        enviado = jsonDecode(peticion.body);
        return json({
          'id': 9,
          ...enviado,
          'estado': 'activo',
          'fechaEntrega': null,
          'estudianteNombre': 'Ana Torres',
          'libroTitulo': 'Rayuela',
          'libroPortada': '/portadas/rayuela.jpg',
        }, 201);
      }),
    );

    final prestamo = await PrestamoApi(cliente).registrarPrestamo(
      PrestamoModel(
        id: null,
        estudianteId: 1,
        libroId: 9,
        fechaPrestamo: DateTime.utc(2026, 11, 2),
        fechaDevolucion: DateTime.utc(2026, 11, 9),
      ),
    );

    expect(enviado, {
      'estudianteId': 1,
      'libroId': 9,
      'fechaPrestamo': '2026-11-02',
      'fechaDevolucion': '2026-11-09',
    });
    expect(prestamo.id, 9);
    expect(prestamo.estado, EstadoPrestamo.activo);
    expect(prestamo.duracionDias, 7);
    expect(prestamo.libroPortadaUrl, '$base/portadas/rayuela.jpg');
  });

  test('los errores de la API llegan como ReglaNegocioException', () async {
    final cliente = ApiCliente(
      baseUrl: base,
      cliente: MockClient(
        (_) async =>
            json({'mensaje': 'El libro no tiene stock disponible'}, 409),
      ),
    );

    expect(
      () => cliente.get('/libros'),
      throwsA(
        isA<ReglaNegocioException>().having(
          (e) => e.mensaje,
          'mensaje',
          'El libro no tiene stock disponible',
        ),
      ),
    );
  });

  test('sin servidor lanza ConexionException', () async {
    final cliente = ApiCliente(
      baseUrl: base,
      cliente: MockClient((_) async => throw http.ClientException('sin red')),
    );

    expect(() => cliente.get('/libros'), throwsA(isA<ConexionException>()));
  });
}
