import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/datasources/objectbox_store.dart';
import '../providers/fruit_provider.dart';
import '../widgets/fruit_tile.dart';
import 'objectbox_debug_page.dart';

class FruitListPage extends StatelessWidget {
  const FruitListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fruitProvider = context.watch<FruitProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruits (ObjectBox)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.storage),
            onPressed: () {
              final store = context.read<ObjectBoxStore>();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ObjectBoxDebugPage(fruitBox: store.fruitBox),
                ),
              );
            },
          ),
        ],
      ),

      body: Builder(
        builder: (context) {
          if (fruitProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (fruitProvider.errorMessage != null) {
            return Center(child: Text(fruitProvider.errorMessage!, textAlign: TextAlign.center));
          }

          final fruits = fruitProvider.fruits;

          if (fruits.isEmpty) {
            return RefreshIndicator(
              onRefresh: () => context.read<FruitProvider>().loadFruits(),
              child: ListView(
                children: const [
                  SizedBox(height: 200),
                  Center(child: Text('No fruits found. Pull to refresh.')),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => context.read<FruitProvider>().loadFruits(),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: fruits.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final fruit = fruits[index];
                return FruitTile(fruit: fruit);
              },
            ),
          );
        },
      ),
    );
  }
}
