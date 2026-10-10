import '../entities/learning_item.dart';
import '../repositories/item_repository.dart';

class GetItems {
  const GetItems(this.repository);
  final ItemRepository repository;
  Future<List<LearningItem>> call() => repository.fetchItems();
}
