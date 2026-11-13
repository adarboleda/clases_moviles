import '../models/prestamo_model.dart';
import 'api_cliente.dart';

class PrestamoApi {
  final ApiCliente cliente;

  PrestamoApi(this.cliente);

  PrestamoModel _convertir(dynamic item) =>
      PrestamoModel.fromJson(item, urlCompleta: cliente.urlCompleta);

  //metodo para obtener prestamos, opcionalmente de un solo estudiante
  Future<List<PrestamoModel>> obtenerPrestamos({int? estudianteId}) async {
    final ruta = estudianteId == null
        ? '/prestamos'
        : '/prestamos?estudianteId=$estudianteId';
    final datos = await cliente.get(ruta) as List;
    return datos.map(_convertir).toList();
  }

  //metodo para registrar prestamo; la API descuenta 1 del stock del libro
  Future<PrestamoModel> registrarPrestamo(PrestamoModel prestamo) async {
    final datos = await cliente.post('/prestamos', prestamo.toJson());
    return _convertir(datos);
  }

  //metodo para registrar devolucion; la API suma 1 al stock del libro
  Future<PrestamoModel> registrarDevolucion(int id) async {
    final datos = await cliente.patch('/prestamos/$id', {'estado': 'devuelto'});
    return _convertir(datos);
  }
}
