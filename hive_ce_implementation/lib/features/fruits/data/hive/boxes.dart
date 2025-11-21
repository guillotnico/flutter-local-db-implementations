import 'package:hive/hive.dart';
import '../models/fruit_model.dart';

class Boxes {
  static late Box<FruitModel> _fruitBox;

  /// À appeler dans main(), une fois la box ouverte.
  static void init(Box<FruitModel> fruitBox) {
    _fruitBox = fruitBox;
  }

  static Box<FruitModel> get fruitBox => _fruitBox;

  /// Map attendue par HiveBoxesView :
  /// - clé : la Box
  /// - valeur : une fonction qui convertit le json en FruitModel
  static Map<Box, dynamic Function(dynamic)> get allBoxes => {
    _fruitBox: (json) =>
        FruitModel.fromJson(Map<String, dynamic>.from(json as Map)),
  };
}
