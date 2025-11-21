import 'package:objectbox/objectbox.dart';

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
    return fruitBox.getAll(); // ObjectBox est sync, mais on garde Future
  }

  @override
  Future<void> saveFruits(List<FruitModel> fruits) async {
    fruitBox.removeAll();
    fruitBox.putMany(fruits);
  }

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
