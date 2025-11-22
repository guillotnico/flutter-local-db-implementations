import 'package:drift_implementation/features/fruits/presentation/widgets/fruit_circular_avatar.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/fruit.dart';

class FruitTile extends StatelessWidget {
  final Fruit fruit;

  const FruitTile({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    final Color cardBackgroundColor = Theme.of(context).cardColor;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      color: cardBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            FruitCircularAvatar(fruit: fruit),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fruit.name,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 4.0),
                  Text('Couleur: ${fruit.color}', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey[700])),
                ],
              ),
            ),

            Text(
              '${fruit.price.toStringAsFixed(2)} €',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.green[700]),
            ),
          ],
        ),
      ),
    );
  }
}
