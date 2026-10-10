import '../entities/learning_item.dart';

abstract interface class ItemRepository {
  Future<List<LearningItem>> fetchItems();
}
