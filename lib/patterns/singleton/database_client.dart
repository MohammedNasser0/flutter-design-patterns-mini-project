import 'database.dart';

class DatabaseClient {
  bool hasSingleInstance() {
    final first = Database.createDatabase();
    final second = Database.createDatabase();
    return identical(first, second);
  }
}
