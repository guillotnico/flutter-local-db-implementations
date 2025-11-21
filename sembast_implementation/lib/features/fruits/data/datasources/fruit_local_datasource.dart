import 'package:sembast/sembast.dart';

import '../models/fruit_model.dart';
import 'app_database.dart';

abstract class FruitLocalDataSource {
  Future<List<FruitModel>> getFruits();
  Future<void> saveFruits(List<FruitModel> fruits);
  List<FruitModel> getInitialFruits();
}

class FruitLocalDataSourceImpl implements FruitLocalDataSource {
  final AppDatabase appDatabase;

  FruitLocalDataSourceImpl({required this.appDatabase});

  StoreRef<String, Map<String, dynamic>> get _store => appDatabase.fruitStore;

  Future<Database> get _db async => appDatabase.database;

  @override
  Future<List<FruitModel>> getFruits() async {
    final db = await _db;

    final records = await _store.find(db);
    return records
        .map((record) =>
        FruitModel.fromMap(record.value as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveFruits(List<FruitModel> fruits) async {
    final db = await _db;

    // On remplace tout le contenu du store
    await db.transaction((txn) async {
      await _store.delete(txn);
      for (final fruit in fruits) {
        await _store.record(fruit.id).put(txn, fruit.toMap());
      }
    });
  }

  @override
  List<FruitModel> getInitialFruits() {
    return const [
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
