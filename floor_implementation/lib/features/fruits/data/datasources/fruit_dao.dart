import 'package:floor/floor.dart';

import '../models/fruit_model.dart';

@dao
abstract class FruitDao {
  @Query('SELECT * FROM fruits')
  Future<List<FruitModel>> getAllFruits();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFruits(List<FruitModel> fruits);

  @Query('DELETE FROM fruits')
  Future<void> deleteAll();
}
