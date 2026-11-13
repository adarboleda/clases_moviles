import 'package:flutter/foundation.dart';

//direccion base de la API REST
//se puede cambiar al ejecutar: flutter run --dart-define=API_URL=http://192.168.1.10:3000
class ApiConfig {
  static const String _urlDefinida = String.fromEnvironment('API_URL');

  static String get baseUrl {
    if (_urlDefinida.isNotEmpty) return _urlDefinida;
    //el emulador de Android llega a la PC con la IP especial 10.0.2.2
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:3000';
    }
    return 'http://localhost:3000';
  }
}
