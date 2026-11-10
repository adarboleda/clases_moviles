import '../../data/datasources/item_api.dart';
import '../../domain/entities/item.dart';
import '../../domain/repositories/item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemApi api;

  ItemRepositoryImpl(this.api);

  @override
  Future<List<Item>> obtenerItems() async {
    return await api.obtenerItems();
  }
}
