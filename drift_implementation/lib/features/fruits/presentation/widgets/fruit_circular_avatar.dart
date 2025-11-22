import 'package:flutter/material.dart';

import '../../domain/entities/fruit.dart';

class FruitCircularAvatar extends StatelessWidget {
  final Fruit fruit;

  const FruitCircularAvatar({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    Color avatarBackgroundColor = Colors.deepOrange.shade100;
    Color avatarTextColor = Colors.deepOrange.shade900;

    final fruitColor = fruit.color.toLowerCase();

    if (fruitColor == 'red') {
      avatarBackgroundColor = Colors.red.shade100;
      avatarTextColor = Colors.red.shade900;
    } else if (fruitColor == 'green') {
      avatarBackgroundColor = Colors.green.shade100;
      avatarTextColor = Colors.green.shade900;
    } else if (fruitColor == 'yellow') {
      avatarBackgroundColor = Colors.yellow.shade100;
      avatarTextColor = Colors.yellow.shade900;
    } else if (fruitColor == 'orange') {
      avatarBackgroundColor = Colors.orange.shade100;
      avatarTextColor = Colors.orange.shade900;
    } else if (fruitColor == 'purple') {
      avatarBackgroundColor = Colors.purple.shade100;
      avatarTextColor = Colors.purple.shade900;
    }

    return CircleAvatar(
      radius: 28.0,
      backgroundColor: avatarBackgroundColor,
      child: Text(
        fruit.name.isNotEmpty ? fruit.name[0].toUpperCase() : '?',
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: avatarTextColor),
      ),
    );
  }
}
