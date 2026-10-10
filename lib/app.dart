import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection.dart';
import 'presentation/cubits/items_cubit.dart';
import 'presentation/screens/items_screen.dart';

class PatternLabApp extends StatelessWidget {
  const PatternLabApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Pattern Lab',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750CF)),
      scaffoldBackgroundColor: const Color(0xFFF7F6FA),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFF7F6FA),
        surfaceTintColor: Colors.transparent,
      ),
    ),
    home: BlocProvider(
      create: (_) => getIt<ItemsCubit>()..fetch(),
      child: const ItemsScreen(),
    ),
  );
}
