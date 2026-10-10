import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_items.dart';
import 'items_state.dart';

class ItemsCubit extends Cubit<ItemsState> {
  ItemsCubit(this.getItems) : super(const ItemsState());
  final GetItems getItems;
  Future<void> fetch() async {
    if (state.status == ItemsStatus.loading) return;
    emit(const ItemsState(status: ItemsStatus.loading));
    try {
      final items = await getItems();
      if (!isClosed) emit(ItemsState(status: ItemsStatus.loaded, items: items));
    } catch (_) {
      if (!isClosed) {
        emit(
          const ItemsState(
            status: ItemsStatus.error,
            message: 'Could not load the learning list. Please try again.',
          ),
        );
      }
    }
  }
}
