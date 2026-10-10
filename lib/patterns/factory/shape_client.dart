import 'shape_factory.dart';

class ShapeClient {
  ShapeClient(this.factory);
  final ShapeFactory factory;
  void run() {
    for (final type in ['Circle', 'Square', 'Rectangle']) {
      factory.getShape(type).revealMe();
    }
  }
}
