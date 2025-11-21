import 'package:objectbox/objectbox.dart';

import '../../domain/entities/fruit.dart';

/// Modèle de persistance ObjectBox pour Fruit.
/// On a un ID interne ObjectBox (obxId) + un ID métier (id).
@Entity()
class FruitModel {
  @Id()
  int obxId;

  String id;     // ID métier (string)
  String name;
  String color;
  double price;

  FruitModel({
    this.obxId = 0,
    required this.id,
    required this.name,
    required this.color,
    required this.price,
  });

  /// Mapping vers l'entité de domaine
  Fruit toEntity() {
    return Fruit(
      id: id,
      name: name,
      color: color,
      price: price,
    );
  }

  /// Mapping depuis l'entité de domaine
  factory FruitModel.fromEntity(Fruit fruit, {int obxId = 0}) {
    return FruitModel(
      obxId: obxId,
      id: fruit.id,
      name: fruit.name,
      color: fruit.color,
      price: fruit.price,
    );
  }
}
