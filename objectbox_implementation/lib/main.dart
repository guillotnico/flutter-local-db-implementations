import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/fruits/data/datasources/fruit_local_datasource.dart';
import 'features/fruits/data/datasources/objectbox_store.dart';
import 'features/fruits/data/repositories/fruit_repository_impl.dart';
import 'features/fruits/domain/usecases/get_all_fruits.dart';
import 'features/fruits/presentation/pages/fruits_page.dart';
import 'features/fruits/presentation/providers/fruit_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ On appelle NOTRE factory, qui elle-même appelle openStore()
  final objectBoxStore = await ObjectBoxStore.create();

  runApp(MyApp(objectBoxStore: objectBoxStore));
}

class MyApp extends StatelessWidget {
  final ObjectBoxStore objectBoxStore;

  const MyApp({super.key, required this.objectBoxStore});

  @override
  Widget build(BuildContext context) {
    final localDataSource =
    FruitLocalDataSourceImpl(fruitBox: objectBoxStore.fruitBox);
    final repository =
    FruitRepositoryImpl(localDataSource: localDataSource);
    final getAllFruitsUseCase = GetAllFruitsUseCase(repository);

    return MultiProvider(
      providers: [
        Provider<ObjectBoxStore>.value(value: objectBoxStore),
        ChangeNotifierProvider(
          create: (_) =>
          FruitProvider(getAllFruitsUseCase: getAllFruitsUseCase)
            ..loadFruits(),
        ),
      ],
      child: MaterialApp(
        title: 'Fruit App - ObjectBox',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.deepPurple,
        ),
        home: const FruitListPage(),
      ),
    );
  }
}
