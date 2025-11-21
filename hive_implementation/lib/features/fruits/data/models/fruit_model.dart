import 'package:hive/hive.dart';
import '../../domain/entities/fruit.dart';

part 'fruit_model.g.dart';

@HiveType(typeId: 0)
class FruitModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String color;

  @HiveField(3)
  double price;

  FruitModel({
    required this.id,
    required this.name,
    required this.color,
    required this.price,
  });

  // Mapping vers l'entité de domaine
  Fruit toEntity() {
    return Fruit(
      id: id,
      name: name,
      color: color,
      price: price,
    );
  }

  // Mapping depuis l'entité de domaine
  factory FruitModel.fromEntity(Fruit fruit) {
    return FruitModel(
      id: fruit.id,
      name: fruit.name,
      color: fruit.color,
      price: fruit.price,
    );
  }

  // ---- Nécessaire pour hive_ui ----

  factory FruitModel.fromJson(Map<String, dynamic> json) {
    return FruitModel(
      id: json['id'] as String,
      name: json['name'] as String,
      color: json['color'] as String,
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'color': color,
      'price': price,
    };
  }
}
