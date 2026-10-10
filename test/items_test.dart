import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:design_patterns_mini_project/domain/usecases/get_items.dart';
import 'package:design_patterns_mini_project/presentation/cubits/items_cubit.dart';
import 'package:design_patterns_mini_project/presentation/cubits/items_state.dart';
import 'package:design_patterns_mini_project/presentation/screens/items_screen.dart';
import 'package:design_patterns_mini_project/data/datasources/local_item_datasource.dart';
import 'package:design_patterns_mini_project/data/models/learning_item_model.dart';

import 'support/fake_item_repository.dart';

void main() {
  test('Cubit emits loading then fetched data', () async {
    final cubit = ItemsCubit(GetItems(FakeItemRepository()));
    final states = <ItemsStatus>[];
    final subscription = cubit.stream.listen(
      (state) => states.add(state.status),
    );
    await cubit.fetch();
    await Future<void>.delayed(Duration.zero);
    expect(states, [ItemsStatus.loading, ItemsStatus.loaded]);
    expect(cubit.state.items.single.title, 'Test item');
    await subscription.cancel();
    await cubit.close();
  });
  test('Cubit catches failures and supports retry', () async {
    final repository = FakeItemRepository()..fail = true;
    final cubit = ItemsCubit(GetItems(repository));
    await cubit.fetch();
    expect(cubit.state.status, ItemsStatus.error);
    repository.fail = false;
    await cubit.fetch();
    expect(cubit.state.status, ItemsStatus.loaded);
    await cubit.close();
  });
  test('Local data contains five JSON-serializable learning items', () async {
    final items = await const LocalItemDataSource(delay: Duration.zero)
        .fetchItems();
    expect(items.length, 5);
    expect(
      LearningItemModel.fromJson(items.first.toJson()).title,
      items.first.title,
    );
  });
  testWidgets('UI displays fetched data and can retry an error', (
    tester,
  ) async {
    final repository = FakeItemRepository()..fail = true;
    final cubit = ItemsCubit(GetItems(repository));
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(value: cubit, child: const ItemsScreen()),
      ),
    );
    await cubit.fetch();
    await tester.pump();
    expect(find.text('Try again'), findsOneWidget);
    repository.fail = false;
    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();
    expect(find.text('Test item'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await cubit.close();
  });
}
