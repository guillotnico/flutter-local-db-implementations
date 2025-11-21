import '../../domain/entities/fruit.dart';

class FruitModel {
  /// ID auto-incrémenté en base (PRIMARY KEY).
  final int? dbId;

  /// ID métier (String), le même que dans l'entité de domaine.
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

  /// Mapping DB -> Model
  factory FruitModel.fromMap(Map<String, dynamic> map) {
    return FruitModel(
      dbId: map['id'] as int?,
      id: map['external_id'] as String,
      name: map['name'] as String,
      color: map['color'] as String,
      price: (map['price'] as num).toDouble(),
    );
  }

  /// Mapping Model -> DB
  Map<String, dynamic> toMap() {
    return {
      'id': dbId,
      'external_id': id,
      'name': name,
      'color': color,
      'price': price,
    };
  }

  /// Model -> Entité de domaine
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
