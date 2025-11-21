import 'package:floor/floor.dart';

import '../../domain/entities/fruit.dart';

@Entity(tableName: 'fruits')
class FruitModel {
  /// ID auto-incrémenté en base (PRIMARY KEY).
  @PrimaryKey(autoGenerate: true)
  final int? id;

  /// ID métier (String), aligné sur l'entité de domaine [Fruit].
  final String externalId;
  final String name;
  final String color;
  final double price;

  const FruitModel({
    this.id,
    required this.externalId,
    required this.name,
    required this.color,
    required this.price,
  });

  /// Model -> entité de domaine.
  Fruit toEntity() {
    return Fruit(
      id: externalId,
      name: name,
      color: color,
      price: price,
    );
  }

  /// Entité de domaine -> Model.
  factory FruitModel.fromEntity(Fruit fruit, {int? id}) {
    return FruitModel(
      id: id,
      externalId: fruit.id,
      name: fruit.name,
      color: fruit.color,
      price: fruit.price,
    );
  }
}
