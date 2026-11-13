import '../models/libro_model.dart';
import 'api_cliente.dart';

class LibroApi {
  final ApiCliente cliente;

  LibroApi(this.cliente);

  //metodo para obtener libros; la API filtra los disponibles con ?disponibles=true
  Future<List<LibroModel>> obtenerLibros({bool soloDisponibles = false}) async {
    final ruta = soloDisponibles ? '/libros?disponibles=true' : '/libros';
    final datos = await cliente.get(ruta) as List;
    return datos
        .map(
          (item) => LibroModel.fromJson(item, urlCompleta: cliente.urlCompleta),
        )
        .toList();
  }

  //metodo para obtener un libro
  Future<LibroModel> obtenerLibro(int id) async {
    final datos = await cliente.get('/libros/$id');
    return LibroModel.fromJson(datos, urlCompleta: cliente.urlCompleta);
  }
}
