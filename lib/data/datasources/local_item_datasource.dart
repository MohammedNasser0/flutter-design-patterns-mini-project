import '../models/learning_item_model.dart';

/// Async local data keeps the architecture demonstration runnable offline.
class LocalItemDataSource {
  const LocalItemDataSource({this.delay = const Duration(milliseconds: 350)});
  final Duration delay;
  Future<List<LearningItemModel>> fetchItems() async {
    await Future<void>.delayed(delay);
    return [
      {
        'id': 1,
        'title': 'Build a flexible User',
        'description': 'Required names. Optional age and phone.',
        'category': 'BUILDER',
      },
      {
        'id': 2,
        'title': 'Let the factory choose',
        'description': 'One interface, three concrete shapes.',
        'category': 'FACTORY',
      },
      {
        'id': 3,
        'title': 'Share one database',
        'description': 'Two requests. The same instance.',
        'category': 'SINGLETON',
      },
      {
        'id': 4,
        'title': 'Keep payments extensible',
        'description': 'Small contracts and injected strategies.',
        'category': 'SOLID',
      },
      {
        'id': 5,
        'title': 'Connect clean layers',
        'description': 'Data → repository → use case → Cubit → UI.',
        'category': 'ARCHITECTURE',
      },
    ].map(LearningItemModel.fromJson).toList(growable: false);
  }
}
