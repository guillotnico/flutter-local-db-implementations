import '../models/fruit_model.dart';
import 'drift_database.dart';

abstract class FruitLocalDataSource {
  Future<List<FruitModel>> getFruits();
  Future<void> saveFruits(List<FruitModel> fruits);
  List<FruitModel> getInitialFruits();
}

class FruitLocalDataSourceImpl implements FruitLocalDataSource {
  final AppDatabase db;

  FruitLocalDataSourceImpl({required this.db});

  @override
  Future<List<FruitModel>> getFruits() async {
    final rows = await db.getAllFruitRows();
    return rows
        .map(
          (row) => FruitModel(
        dbId: row.id,
        id: row.externalId,
        name: row.name,
        color: row.color,
        price: row.price,
      ),
    )
        .toList();
  }

  @override
  Future<void> saveFruits(List<FruitModel> fruits) async {
    // On convertit les models en FruitRow pour utiliser replaceAllFruits().
    final rows = fruits
        .map(
          (model) => FruitRow(
        id: model.dbId ?? 0, // la PK ne sert pas vraiment ici, on remplace tout
        externalId: model.id,
        name: model.name,
        color: model.color,
        price: model.price,
      ),
    )
        .toList();

    await db.replaceAllFruits(rows);
  }

  /// Fruits "en dur" pour initialiser la DB si elle est vide.
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
