import '../../domain/entities/learning_item.dart';

class LearningItemModel extends LearningItem {
  const LearningItemModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
  });
  factory LearningItemModel.fromJson(Map<String, dynamic> json) =>
      LearningItemModel(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        category: json['category'] as String,
      );
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'category': category,
  };
}
