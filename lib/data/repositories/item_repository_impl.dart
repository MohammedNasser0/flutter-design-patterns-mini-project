import '../../domain/entities/learning_item.dart';
import '../../domain/repositories/item_repository.dart';
import '../datasources/local_item_datasource.dart';

class ItemRepositoryImpl implements ItemRepository {
  const ItemRepositoryImpl(this.source);
  final LocalItemDataSource source;
  @override
  Future<List<LearningItem>> fetchItems() => source.fetchItems();
}
