import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/fruits/data/datasources/app_database.dart';
import 'features/fruits/data/datasources/fruit_local_datasource.dart';
import 'features/fruits/data/repositories/fruit_repository_impl.dart';
import 'features/fruits/domain/usecases/get_all_fruits.dart';
import 'features/fruits/presentation/pages/fruits_page.dart';
import 'features/fruits/presentation/providers/fruit_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDatabase = AppDatabase();

  runApp(MyApp(appDatabase: appDatabase));
}

class MyApp extends StatelessWidget {
  final AppDatabase appDatabase;

  const MyApp({super.key, required this.appDatabase});

  @override
  Widget build(BuildContext context) {
    final localDataSource = FruitLocalDataSourceImpl(appDatabase: appDatabase);
    final repository = FruitRepositoryImpl(localDataSource: localDataSource);
    final getAllFruitsUseCase = GetAllFruitsUseCase(repository);

    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => FruitProvider(getAllFruitsUseCase: getAllFruitsUseCase)..loadFruits())],
      child: MaterialApp(
        title: 'Fruit App - Sqflite',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blueGrey),
        home: const FruitListPage(),
      ),
    );
  }
}
