import '../../domain/entities/fruit.dart';

class FruitModel {
  /// ID auto-incrémenté dans la DB (PRIMARY KEY).
  final int? dbId;

  /// ID métier (String), aligné sur l'entité de domaine [Fruit.id].
  final String id;
  final String name;
  final String color;
  final double price;

  const FruitModel({
    this.dbId,
    required this.id,
    required this.name,
    required this.color,
    required this.price,
  });

  /// Model -> entité de domaine
  Fruit toEntity() {
    return Fruit(
      id: id,
      name: name,
      color: color,
      price: price,
    );
  }

  /// Entité de domaine -> Model
  factory FruitModel.fromEntity(Fruit fruit, {int? dbId}) {
    return FruitModel(
      dbId: dbId,
      id: fruit.id,
      name: fruit.name,
      color: fruit.color,
      price: fruit.price,
    );
  }
}
