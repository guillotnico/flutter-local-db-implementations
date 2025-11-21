import '../../domain/entities/fruit.dart';

class FruitModel {
  /// Clé interne Sembast (optionnelle, si tu veux l'utiliser).
  final String id;

  final String name;
  final String color;
  final double price;

  const FruitModel({
    required this.id,
    required this.name,
    required this.color,
    required this.price,
  });

  /// DB (Map) -> Model
  factory FruitModel.fromMap(Map<String, dynamic> map) {
    return FruitModel(
      id: map['id'] as String,
      name: map['name'] as String,
      color: map['color'] as String,
      price: (map['price'] as num).toDouble(),
    );
  }

  /// Model -> DB (Map)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'price': price,
    };
  }

  /// Model -> entité de domaine
  Fruit toEntity() {
    return Fruit(
      id: id,
      name: name,
      color: color,
      price: price,
    );
  }

  /// Entité -> Model
  factory FruitModel.fromEntity(Fruit fruit) {
    return FruitModel(
      id: fruit.id,
      name: fruit.name,
      color: fruit.color,
      price: fruit.price,
    );
  }
}
