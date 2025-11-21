// DATA LAYER - REPOSITORY IMPLEMENTATION

import '../../domain/entities/fruit.dart';
import '../../domain/repositories/fruit_repository.dart';

import '../datasources/fruit_local_datasource.dart';
import '../models/fruit_model.dart';

class FruitRepositoryImpl implements FruitRepository {
  final FruitLocalDataSource localDataSource;

  FruitRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Fruit>> getAllFruits() async {
    // On récupère ce qu'il y a dans Hive
    final fruitsInDb = await localDataSource.getFruits();

    if (fruitsInDb.isNotEmpty) {
      return fruitsInDb.map((m) => m.toEntity()).toList();
    }

    // Si la DB est vide, on seed avec les fruits en dur
    final initialModels = localDataSource.getInitialFruits();
    await localDataSource.saveFruits(initialModels);

    return initialModels.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> saveFruits(List<Fruit> fruits) async {
    final models = fruits.map(FruitModel.fromEntity).toList();
    await localDataSource.saveFruits(models);
  }
}
