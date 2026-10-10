import '../../domain/entities/learning_item.dart';

enum ItemsStatus { initial, loading, loaded, error }

class ItemsState {
  const ItemsState({
    this.status = ItemsStatus.initial,
    this.items = const [],
    this.message,
  });
  final ItemsStatus status;
  final List<LearningItem> items;
  final String? message;
}
