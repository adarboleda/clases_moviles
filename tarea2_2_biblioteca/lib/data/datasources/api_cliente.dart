import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/api_config.dart';
import '../../domain/errores/biblioteca_exception.dart';

//se lanza cuando la app no puede comunicarse con la API
class ConexionException extends BibliotecaException {
  const ConexionException(super.mensaje);
}

//cliente HTTP comun para todas las fuentes de datos
class ApiCliente {
  final String baseUrl;
  final http.Client _http;

  ApiCliente({String? baseUrl, http.Client? cliente})
    : baseUrl = baseUrl ?? ApiConfig.baseUrl,
      _http = cliente ?? http.Client();

  static const _cabeceras = {'Content-Type': 'application/json'};

  Future<dynamic> get(String ruta) {
    return _enviar(() => _http.get(Uri.parse('$baseUrl$ruta')));
  }

  Future<dynamic> post(String ruta, Map<String, dynamic> cuerpo) {
    return _enviar(
      () => _http.post(
        Uri.parse('$baseUrl$ruta'),
        headers: _cabeceras,
        body: jsonEncode(cuerpo),
      ),
    );
  }

  Future<dynamic> patch(String ruta, Map<String, dynamic> cuerpo) {
    return _enviar(
      () => _http.patch(
        Uri.parse('$baseUrl$ruta'),
        headers: _cabeceras,
        body: jsonEncode(cuerpo),
      ),
    );
  }

  //convierte una ruta relativa de la API (por ejemplo /portadas/a.jpg) en una URL completa
  String urlCompleta(String ruta) {
    if (ruta.isEmpty || ruta.startsWith('http')) return ruta;
    return '$baseUrl$ruta';
  }

  Future<dynamic> _enviar(Future<http.Response> Function() peticion) async {
    final http.Response respuesta;
    try {
      respuesta = await peticion().timeout(const Duration(seconds: 10));
    } catch (_) {
      throw ConexionException(
        'No se pudo conectar con la API ($baseUrl). '
        'Verifica que el servidor esté encendido.',
      );
    }

    dynamic cuerpo;
    try {
      cuerpo = respuesta.bodyBytes.isEmpty
          ? null
          : jsonDecode(utf8.decode(respuesta.bodyBytes));
    } on FormatException {
      cuerpo = null;
    }

    final codigo = respuesta.statusCode;
    if (codigo >= 200 && codigo < 300) return cuerpo;

    //la API responde los errores como {"mensaje": "..."}
    final mensaje = cuerpo is Map && cuerpo['mensaje'] is String
        ? cuerpo['mensaje'] as String
        : 'La API respondió con el código $codigo';
    if (codigo >= 400 && codigo < 500) throw ReglaNegocioException(mensaje);
    throw BibliotecaException(mensaje);
  }
}
