import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'features/fruits/data/datasources/app_database.dart';
import 'features/fruits/data/datasources/fruit_dao.dart';
import 'features/fruits/data/datasources/fruit_local_datasource.dart';
import 'features/fruits/data/repositories/fruit_repository_impl.dart';
import 'features/fruits/domain/usecases/get_all_fruits.dart';
import 'features/fruits/presentation/pages/fruits_page.dart';
import 'features/fruits/presentation/providers/fruit_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  final dbPath = p.join(dir.path, 'fruits_floor.db');

  debugPrint('Floor DB path: $dbPath');

  // AppDatabase est générée en $FloorAppDatabase dans app_database.g.dart
  final database =
  await $FloorAppDatabase.databaseBuilder(dbPath).build();

  final fruitDao = database.fruitDao;

  runApp(MyApp(fruitDao: fruitDao));
}

class MyApp extends StatelessWidget {
  final FruitDao fruitDao;

  const MyApp({super.key, required this.fruitDao});

  @override
  Widget build(BuildContext context) {
    final localDataSource =
    FruitLocalDataSourceImpl(fruitDao: fruitDao);
    final repository =
    FruitRepositoryImpl(localDataSource: localDataSource);
    final getAllFruitsUseCase = GetAllFruitsUseCase(repository);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
          FruitProvider(getAllFruitsUseCase: getAllFruitsUseCase)
            ..loadFruits(),
        ),
      ],
      child: MaterialApp(
        title: 'Fruit App - Floor',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.orange,
        ),
        home: const FruitListPage(),
      ),
    );
  }
}
