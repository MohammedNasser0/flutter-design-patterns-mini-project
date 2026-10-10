import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/items_cubit.dart';
import '../cubits/items_state.dart';
import '../widgets/learning_item_card.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text(
        'patternlab.',
        style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: -1),
      ),
      actions: [
        IconButton(
          tooltip: 'Reload items',
          onPressed: () => context.read<ItemsCubit>().fetch(),
          icon: const Icon(Icons.refresh_rounded),
        ),
        const SizedBox(width: 12),
      ],
    ),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: BlocBuilder<ItemsCubit, ItemsState>(
          builder: (context, state) {
            if (state.status == ItemsStatus.loading ||
                state.status == ItemsStatus.initial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == ItemsStatus.error) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message!),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: context.read<ItemsCubit>().fetch,
                    child: const Text('Try again'),
                  ),
                ],
              );
            }
            return RefreshIndicator(
              onRefresh: context.read<ItemsCubit>().fetch,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(
                  MediaQuery.sizeOf(context).width < 400 ? 18 : 28,
                ),
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF27203E),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'THE FLUTTER MINI PROJECT',
                          style: TextStyle(
                            color: Color(0xFFB6A4FF),
                            fontSize: 10,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Small patterns. Better architecture.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Five practical steps to cleaner, more maintainable code.',
                          style: TextStyle(
                            color: Color(0xFFBDB5CE),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Your learning list',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        '${state.items.length} ITEMS',
                        style: const TextStyle(
                          color: Color(0xFF77758B),
                          fontSize: 11,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (state.items.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text('No learning items yet.'),
                    ),
                  ...state.items.map((item) => LearningItemCard(item: item)),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'LOCAL DATA  /  GETIT  /  CUBIT',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF9995A8),
                        fontSize: 10,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ),
  );
}
