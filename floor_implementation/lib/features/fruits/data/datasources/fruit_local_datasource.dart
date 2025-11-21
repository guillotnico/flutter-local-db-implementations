import '../models/fruit_model.dart';
import 'fruit_dao.dart';

abstract class FruitLocalDataSource {
  Future<List<FruitModel>> getFruits();
  Future<void> saveFruits(List<FruitModel> fruits);
  List<FruitModel> getInitialFruits();
}

class FruitLocalDataSourceImpl implements FruitLocalDataSource {
  final FruitDao fruitDao;

  FruitLocalDataSourceImpl({required this.fruitDao});

  @override
  Future<List<FruitModel>> getFruits() async {
    return fruitDao.getAllFruits();
  }

  @override
  Future<void> saveFruits(List<FruitModel> fruits) async {
    // Stratégie simple : on remplace tout.
    await fruitDao.deleteAll();
    await fruitDao.insertFruits(fruits);
  }

  /// Fruits "en dur" pour initialiser la DB si elle est vide.
  @override
  List<FruitModel> getInitialFruits() {
    return const [
      FruitModel(
        externalId: '1',
        name: 'Apple',
        color: 'Red',
        price: 1.50,
      ),
      FruitModel(
        externalId: '2',
        name: 'Banana',
        color: 'Yellow',
        price: 0.99,
      ),
      FruitModel(
        externalId: '3',
        name: 'Orange',
        color: 'Orange',
        price: 1.20,
      ),
      FruitModel(
        externalId: '4',
        name: 'Grapes',
        color: 'Purple',
        price: 2.80,
      ),
      FruitModel(
        externalId: '5',
        name: 'Kiwi',
        color: 'Green',
        price: 1.10,
      ),
    ];
  }
}
