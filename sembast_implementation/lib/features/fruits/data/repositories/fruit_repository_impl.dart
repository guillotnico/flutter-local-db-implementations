import '../../domain/entities/fruit.dart';
import '../../domain/repositories/fruit_repository.dart';
import '../datasources/fruit_local_datasource.dart';
import '../models/fruit_model.dart';

class FruitRepositoryImpl implements FruitRepository {
  final FruitLocalDataSource localDataSource;

  FruitRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Fruit>> getAllFruits() async {
    final fruitsInDb = await localDataSource.getFruits();

    if (fruitsInDb.isNotEmpty) {
      return fruitsInDb.map((m) => m.toEntity()).toList();
    }

    // DB vide -> seed initial
    final initialModels = localDataSource.getInitialFruits();
    await localDataSource.saveFruits(initialModels);

    return initialModels.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> saveFruits(List<Fruit> fruits) async {
    final models =
    fruits.map((fruit) => FruitModel.fromEntity(fruit)).toList();
    await localDataSource.saveFruits(models);
  }
}
