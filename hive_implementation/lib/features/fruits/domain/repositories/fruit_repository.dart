import '../entities/fruit.dart';

abstract class FruitRepository {
  Future<List<Fruit>> getAllFruits();
  Future<void> saveFruits(List<Fruit> fruits);
}