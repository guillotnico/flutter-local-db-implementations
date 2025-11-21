import 'package:isar_community/isar.dart';

import '../models/fruit_model.dart';

abstract class FruitLocalDataSource {
  Future<List<FruitModel>> getFruits();
  Future<void> saveFruits(List<FruitModel> fruits);
  List<FruitModel> getInitialFruits();
}

class FruitLocalDataSourceImpl implements FruitLocalDataSource {
  final Isar isar;

  FruitLocalDataSourceImpl({required this.isar});

  @override
  Future<List<FruitModel>> getFruits() async {
    // isar.fruitModels est généré dans fruit_model.g.dart
    return await isar.fruitModels.where().findAll();
  }

  @override
  Future<void> saveFruits(List<FruitModel> fruits) async {
    await isar.writeTxn(() async {
      await isar.fruitModels.clear();
      await isar.fruitModels.putAll(fruits);
    });
  }

  /// Fruits "en dur" utilisés pour initialiser la base si vide.
  @override
  List<FruitModel> getInitialFruits() {
    return [
      FruitModel()
        ..externalId = '1'
        ..name = 'Apple'
        ..color = 'Red'
        ..price = 1.50,
      FruitModel()
        ..externalId = '2'
        ..name = 'Banana'
        ..color = 'Yellow'
        ..price = 0.99,
      FruitModel()
        ..externalId = '3'
        ..name = 'Orange'
        ..color = 'Orange'
        ..price = 1.20,
      FruitModel()
        ..externalId = '4'
        ..name = 'Grapes'
        ..color = 'Purple'
        ..price = 2.80,
      FruitModel()
        ..externalId = '5'
        ..name = 'Kiwi'
        ..color = 'Green'
        ..price = 1.10,
    ];
  }
}
