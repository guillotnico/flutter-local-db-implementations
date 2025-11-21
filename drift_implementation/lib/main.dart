import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/fruits/data/datasources/drift_database.dart';
import 'features/fruits/data/datasources/fruit_local_datasource.dart';
import 'features/fruits/data/repositories/fruit_repository_impl.dart';
import 'features/fruits/domain/usecases/get_all_fruits.dart';
import 'features/fruits/presentation/pages/fruits_page.dart';
import 'features/fruits/presentation/providers/fruit_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = AppDatabase();

  runApp(MyApp(db: db));
}

class MyApp extends StatelessWidget {
  final AppDatabase db;

  const MyApp({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    final localDataSource = FruitLocalDataSourceImpl(db: db);
    final repository = FruitRepositoryImpl(localDataSource: localDataSource);
    final getAllFruitsUseCase = GetAllFruitsUseCase(repository);

    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => FruitProvider(getAllFruitsUseCase: getAllFruitsUseCase)..loadFruits())],
      child: MaterialApp(
        title: 'Fruit App - Drift',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
        home: const FruitListPage(),
      ),
    );
  }
}
