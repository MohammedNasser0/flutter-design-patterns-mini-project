import 'package:design_patterns_mini_project/domain/entities/learning_item.dart';
import 'package:design_patterns_mini_project/domain/repositories/item_repository.dart';

class FakeItemRepository implements ItemRepository {
  bool fail = false;
  @override
  Future<List<LearningItem>> fetchItems() async {
    if (fail) throw StateError('Test failure');
    return const [
      LearningItem(
        id: 1,
        title: 'Test item',
        description: 'Fetched through use case',
        category: 'TEST',
      ),
    ];
  }
}
