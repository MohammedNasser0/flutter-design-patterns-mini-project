/// Singleton: private construction and a lazy cached instance prevent duplicates.
class Database {
  Database._();
  static Database? _instance;
  static Database createDatabase() => _instance ??= Database._();
}
