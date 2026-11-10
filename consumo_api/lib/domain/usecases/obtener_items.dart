import '../entities/item.dart';
import '../repositories/item_repository.dart';

class ObtenerItems {
  final ItemRepository repository;

  ObtenerItems(this.repository);

  Future<List<Item>> ejecutar() {
    return repository.obtenerItems();
  }
}
