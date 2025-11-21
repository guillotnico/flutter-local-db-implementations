import 'package:flutter/material.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'features/fruits/data/datasources/fruit_local_datasource.dart';
import 'features/fruits/data/models/fruit_model.dart';
import 'features/fruits/data/repositories/fruit_repository_impl.dart';
import 'features/fruits/domain/usecases/get_all_fruits.dart';
import 'features/fruits/presentation/pages/fruits_page.dart';
import 'features/fruits/presentation/providers/fruit_provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Récupérer le dossier pour la DB Isar
  final dir = await getApplicationDocumentsDirectory();

  // Ouvrir Isar avec le schema de FruitModel
  final isar = await Isar.open(
    [FruitModelSchema],
    directory: dir.path,
    inspector: true, // pratique en dev pour Isar Inspector
  );

  runApp(MyApp(isar: isar));
}

class MyApp extends StatelessWidget {
  final Isar isar;

  const MyApp({super.key, required this.isar});

  @override
  Widget build(BuildContext context) {
    final localDataSource = FruitLocalDataSourceImpl(isar: isar);
    final repository = FruitRepositoryImpl(localDataSource: localDataSource);
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
        title: 'Fruit App - Isar',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.teal,
        ),
        home: const FruitListPage(),
      ),
    );
  }
}
