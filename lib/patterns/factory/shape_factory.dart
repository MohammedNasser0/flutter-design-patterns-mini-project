import 'shape.dart';
import 'circle.dart';
import 'rectangle.dart';
import 'square.dart';

/// Factory hides concrete constructors from clients.
class ShapeFactory {
  Shape getShape(String type) {
    switch (type.trim().toLowerCase()) {
      case 'circle':
        return Circle();
      case 'rectangle':
        return Rectangle();
      case 'square':
        return Square();
      default:
        throw ArgumentError.value(type, 'type', 'Unsupported shape');
    }
  }
}
