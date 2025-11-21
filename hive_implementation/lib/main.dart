import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:provider/provider.dart';

import 'features/fruits/data/datasources/fruit_local_datasource.dart';
import 'features/fruits/data/hive/boxes.dart';
import 'features/fruits/data/models/fruit_model.dart';
import 'features/fruits/data/repositories/fruit_repository_impl.dart';
import 'features/fruits/domain/usecases/get_all_fruits.dart';
import 'features/fruits/presentation/pages/fruits_page.dart';
import 'features/fruits/presentation/providers/fruit_provider.dart';

bool _hiveInitialized = false; // 👈 garde-fou global

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔁 Init Hive une seule fois
  if (!_hiveInitialized) {
    await Hive.initFlutter();

    // 👇 Évite l’erreur "There is already a TypeAdapter for typeId 0"
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(FruitModelAdapter());
      debugPrint('Hive: FruitModelAdapter enregistré (typeId 0).');
    } else {
      debugPrint(
          'Hive: FruitModelAdapter déjà enregistré, on ne le ré-enregistre pas.');
    }

    _hiveInitialized = true;
  }

  // Ouverture / ré-ouverture de la box (openBox est idempotent)
  final fruitBox = await Hive.openBox<FruitModel>('fruits_box');
  Boxes.init(fruitBox);

  runApp(MyApp(fruitBox: fruitBox));
}

class MyApp extends StatelessWidget {
  final Box<FruitModel> fruitBox;

  const MyApp({super.key, required this.fruitBox});

  @override
  Widget build(BuildContext context) {
    final localDataSource = FruitLocalDataSourceImpl(fruitBox: fruitBox);
    final repository = FruitRepositoryImpl(localDataSource: localDataSource);
    final getAllFruitsUseCase = GetAllFruitsUseCase(repository);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
          FruitProvider(getAllFruitsUseCase: getAllFruitsUseCase)
            ..loadFruits(), // seed + chargement
        ),
      ],
      child: MaterialApp(
        title: 'Fruit App',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.green,
        ),
        home: const FruitListPage(),
      ),
    );
  }
}
