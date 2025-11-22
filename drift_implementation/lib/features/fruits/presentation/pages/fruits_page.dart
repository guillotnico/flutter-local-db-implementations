import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/fruit_provider.dart';
import '../widgets/fruit_tile.dart';

class FruitListPage extends StatelessWidget {
  const FruitListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fruitProvider = context.watch<FruitProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: .center, spacing: 8, children: [Icon(Icons.apple), const Text('Fruits list (using Drift)')]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Builder(
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
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: const [
                    SizedBox(height: 200),
                    Center(child: Text('No fruits found. Pull to refresh.')),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () => context.read<FruitProvider>().loadFruits(),
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: fruits.length,

                itemBuilder: (context, index) {
                  final fruit = fruits[index];
                  return FruitTile(fruit: fruit);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
