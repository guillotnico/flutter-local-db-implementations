import 'package:isar_community/isar.dart';

import '../../domain/entities/fruit.dart';

part 'fruit_model.g.dart';

/// Modèle de persistance Isar pour Fruit.
/// On a un ID interne auto-incrémenté (isarId) + un ID métier (externalId).
@collection
class FruitModel {
  Id id = Isar.autoIncrement; // ID interne Isar (int)

  late String externalId; // ID métier (String)
  late String name;
  late String color;
  late double price;

  FruitModel();

  /// Mapping vers l'entité de domaine.
  Fruit toEntity() {
    return Fruit(
      id: externalId,
      name: name,
      color: color,
      price: price,
    );
  }

  /// Mapping depuis l'entité de domaine.
  factory FruitModel.fromEntity(Fruit fruit) {
    final model = FruitModel()
      ..externalId = fruit.id
      ..name = fruit.name
      ..color = fruit.color
      ..price = fruit.price;
    return model;
  }
}
