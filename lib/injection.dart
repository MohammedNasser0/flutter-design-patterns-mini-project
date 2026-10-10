import 'package:get_it/get_it.dart';

import 'data/datasources/local_item_datasource.dart';
import 'data/repositories/item_repository_impl.dart';
import 'domain/repositories/item_repository.dart';
import 'domain/usecases/get_items.dart';
import 'presentation/cubits/items_cubit.dart';

final getIt = GetIt.instance;
void setupDependencies() {
  getIt.registerLazySingleton<LocalItemDataSource>(
    () => const LocalItemDataSource(),
  );
  getIt.registerLazySingleton<ItemRepository>(
    () => ItemRepositoryImpl(getIt<LocalItemDataSource>()),
  );
  getIt.registerLazySingleton<GetItems>(
    () => GetItems(getIt<ItemRepository>()),
  );
  // Each screen receives a new Cubit; its BlocProvider owns disposal.
  getIt.registerFactory<ItemsCubit>(() => ItemsCubit(getIt<GetItems>()));
}
