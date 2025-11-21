import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

import '../../data/models/fruit_model.dart';

class ObjectBoxDebugPage extends StatelessWidget {
  final Box<FruitModel> fruitBox;

  const ObjectBoxDebugPage({
    super.key,
    required this.fruitBox,
  });

  @override
  Widget build(BuildContext context) {
    final fruits = fruitBox.getAll();

    return Scaffold(
      appBar: AppBar(
        title: const Text('ObjectBox Debug - Fruits'),
      ),
      body: ListView.separated(
        itemCount: fruits.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final f = fruits[index];
          return ListTile(
            title: Text('${f.name} (${f.id})'),
            subtitle: Text('Color: ${f.color} • Price: ${f.price}'),
            trailing: Text('obxId: ${f.obxId}'),
          );
        },
      ),
    );
  }
}
