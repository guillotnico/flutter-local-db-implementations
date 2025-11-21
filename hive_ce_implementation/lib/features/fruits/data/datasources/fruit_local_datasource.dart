import 'package:hive/hive.dart';
import '../models/fruit_model.dart';

abstract class FruitLocalDataSource {
  Future<List<FruitModel>> getFruits();
  Future<void> saveFruits(List<FruitModel> fruits);
  List<FruitModel> getInitialFruits();
}

class FruitLocalDataSourceImpl implements FruitLocalDataSource {
  final Box<FruitModel> fruitBox;

  FruitLocalDataSourceImpl({required this.fruitBox});

  @override
  Future<List<FruitModel>> getFruits() async {
    return fruitBox.values.toList();
  }

  @override
  Future<void> saveFruits(List<FruitModel> fruits) async {
    await fruitBox.clear();
    await fruitBox.addAll(fruits);
  }

  /// Fruits "en dur" dans l'app. Utilisés si la base est vide.
  @override
  List<FruitModel> getInitialFruits() {
    return [
      FruitModel(
        id: '1',
        name: 'Apple',
        color: 'Red',
        price: 1.50,
      ),
      FruitModel(
        id: '2',
        name: 'Banana',
        color: 'Yellow',
        price: 0.99,
      ),
      FruitModel(
        id: '3',
        name: 'Orange',
        color: 'Orange',
        price: 1.20,
      ),
      FruitModel(
        id: '4',
        name: 'Grapes',
        color: 'Purple',
        price: 2.80,
      ),
      FruitModel(
        id: '5',
        name: 'Kiwi',
        color: 'Green',
        price: 1.10,
      ),
    ];
  }
}
