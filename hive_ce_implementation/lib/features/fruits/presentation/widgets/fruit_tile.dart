import 'package:flutter/material.dart';
import '../../domain/entities/fruit.dart';

class FruitTile extends StatelessWidget {
  final Fruit fruit;

  const FruitTile({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(

        child: Text(
          fruit.name.isNotEmpty ? fruit.name[0].toUpperCase() : '?',
        ),
      ),
      title: Text(fruit.name),
      subtitle: Text('Color: ${fruit.color}'),
      trailing: Text(
        '${fruit.price.toStringAsFixed(2)} €',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
