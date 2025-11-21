import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_implementation/features/fruits/domain/usecases/get_all_fruits.dart';
import 'package:hive_implementation/features/fruits/presentation/pages/fruits_page.dart';
import 'package:hive_implementation/features/fruits/presentation/providers/fruit_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../fixtures/fruit_fixtures.dart';

class MockGetAllFruitsUseCase extends Mock
    implements GetAllFruitsUseCase {}

void main() {
  testWidgets(
      'affiche la liste des fruits quand le provider a des données',
          (tester) async {
        final mockUseCase = MockGetAllFruitsUseCase();

        when(() => mockUseCase())
            .thenAnswer((_) async => tFruitList);

        final provider = FruitProvider(getAllFruitsUseCase: mockUseCase);

        await tester.pumpWidget(
          MaterialApp(
            home: ChangeNotifierProvider.value(
              value: provider,
              child: const FruitListPage(),
            ),
          ),
        );

        // On déclenche le chargement manuellement
        await provider.loadFruits();
        await tester.pumpAndSettle();

        // Vérifie que les textes sont bien dans l'UI
        expect(find.text('Apple'), findsOneWidget);
        expect(find.text('Banana'), findsOneWidget);
      });
}
