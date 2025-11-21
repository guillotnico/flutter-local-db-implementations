import 'package:sqflite/sqflite.dart';

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

  Future<Database> get _db async => await appDatabase.database;

  @override
  Future<List<FruitModel>> getFruits() async {
    final db = await _db;
    final result = await db.query(AppDatabase.fruitsTable);
    return result.map(FruitModel.fromMap).toList();
  }

  @override
  Future<void> saveFruits(List<FruitModel> fruits) async {
    final db = await _db;

    await db.transaction((txn) async {
      await txn.delete(AppDatabase.fruitsTable);

      for (final fruit in fruits) {
        await txn.insert(
          AppDatabase.fruitsTable,
          fruit.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  /// Fruits "en dur" pour initialiser la DB si elle est vide.
  @override
  List<FruitModel> getInitialFruits() {
    return [
      const FruitModel(
        id: '1',
        name: 'Apple',
        color: 'Red',
        price: 1.50,
      ),
      const FruitModel(
        id: '2',
        name: 'Banana',
        color: 'Yellow',
        price: 0.99,
      ),
      const FruitModel(
        id: '3',
        name: 'Orange',
        color: 'Orange',
        price: 1.20,
      ),
      const FruitModel(
        id: '4',
        name: 'Grapes',
        color: 'Purple',
        price: 2.80,
      ),
      const FruitModel(
        id: '5',
        name: 'Kiwi',
        color: 'Green',
        price: 1.10,
      ),
    ];
  }
}
