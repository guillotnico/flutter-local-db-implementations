

import '../entities/fruit.dart';
import '../repositories/fruit_repository.dart';

class GetAllFruitsUseCase {
  final FruitRepository repository;

  GetAllFruitsUseCase(this.repository);

  Future<List<Fruit>> call() {
    return repository.getAllFruits();
  }
}
