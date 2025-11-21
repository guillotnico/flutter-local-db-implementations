import 'package:flutter_test/flutter_test.dart';
import 'package:hive_implementation/features/fruits/data/datasources/fruit_local_datasource.dart';
import 'package:hive_implementation/features/fruits/data/models/fruit_model.dart';
import 'package:hive_implementation/features/fruits/data/repositories/fruit_repository_impl.dart';
import 'package:mocktail/mocktail.dart';


import '../../fixtures/fruit_fixtures.dart';

class MockFruitLocalDataSource extends Mock
    implements FruitLocalDataSource {}

void logSection(String title) {
  print('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  print('🧪 $title');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
}

void logStep(String message) {
  print('   👉 $message');
}

void main() {
  late FruitRepositoryImpl repository;
  late MockFruitLocalDataSource mockLocal;

  setUp(() {
    mockLocal = MockFruitLocalDataSource();
    repository = FruitRepositoryImpl(localDataSource: mockLocal);
  });

  test('DB non vide -> renvoie les fruits de la DB', () async {
    logSection('Test: DB non vide -> renvoie les fruits de la DB');

    when(() => mockLocal.getFruits())
        .thenAnswer((_) async => tFruitModelList);

    logStep('On appelle repository.getAllFruits() avec une DB simulée non vide.');
    final result = await repository.getAllFruits();

    logStep('On vérifie que la taille de la liste et les valeurs correspondent aux fixtures.');
    expect(result.length, tFruitList.length);

    for (var i = 0; i < result.length; i++) {
      expect(result[i].id, tFruitList[i].id);
      expect(result[i].name, tFruitList[i].name);
      expect(result[i].color, tFruitList[i].color);
      expect(result[i].price, tFruitList[i].price);
    }

    verify(() => mockLocal.getFruits()).called(1);
    verifyNever(() => mockLocal.getInitialFruits());
    verifyNever(() => mockLocal.saveFruits(any()));

    print('✅ Test DB non vide OK');
  });

  test('DB vide -> seed initial de 5 fruits puis renvoie', () async {
    logSection('Test: DB vide -> seed initial de 5 fruits puis renvoie');

    // ARRANGE
    logStep('On simule une DB vide.');
    when(() => mockLocal.getFruits())
        .thenAnswer((_) async => <FruitModel>[]);

    logStep('On renvoie la liste de seed (5 fruits) via getInitialFruits().');
    when(() => mockLocal.getInitialFruits())
        .thenReturn(tFruitModelList);

    when(() => mockLocal.saveFruits(any()))
        .thenAnswer((_) async => {});

    // ACT
    logStep('On appelle repository.getAllFruits().');
    final result = await repository.getAllFruits();

    // ASSERT
    logStep('On vérifie qu’on a bien 5 fruits seedés.');
    expect(result.length, 5);

    logStep('On vérifie que chaque fruit correspond aux fixtures.');
    for (var i = 0; i < result.length; i++) {
      expect(result[i].id, tFruitList[i].id);
      expect(result[i].name, tFruitList[i].name);
      expect(result[i].color, tFruitList[i].color);
      expect(result[i].price, tFruitList[i].price);
    }

    logStep('On vérifie l’ordre des appels sur la datasource.');
    verify(() => mockLocal.getFruits()).called(1);
    verify(() => mockLocal.getInitialFruits()).called(1);
    verify(() => mockLocal.saveFruits(tFruitModelList)).called(1);

    print('✅ Test DB vide + seed de 5 fruits OK');
  });
}
