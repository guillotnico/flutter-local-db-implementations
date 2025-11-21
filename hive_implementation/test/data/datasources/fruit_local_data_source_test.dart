import 'package:flutter_test/flutter_test.dart';
import 'package:hive_implementation/features/fruits/data/datasources/fruit_local_datasource.dart';
import 'package:hive_implementation/features/fruits/data/models/fruit_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hive/hive.dart';



import '../../fixtures/fruit_fixtures.dart';

class MockFruitBox extends Mock implements Box<FruitModel> {}

void main() {
  late FruitLocalDataSourceImpl dataSource;
  late MockFruitBox mockBox;

  setUp(() {
    mockBox = MockFruitBox();
    dataSource = FruitLocalDataSourceImpl(fruitBox: mockBox);
  });

  test('getFruits retourne les valeurs de la box', () async {
    // arrange
    when(() => mockBox.values).thenReturn(tFruitModelList);

    // act
    final result = await dataSource.getFruits();

    // assert
    expect(result, equals(tFruitModelList));
    verify(() => mockBox.values).called(1);
  });

  test('saveFruits clear puis addAll', () async {
    // arrange
    when(() => mockBox.clear()).thenAnswer((_) async => 0);
    when(() => mockBox.addAll(any()))
        .thenAnswer((_) async => <int>[]);

    // act
    await dataSource.saveFruits(tFruitModelList);

    // assert
    verify(() => mockBox.clear()).called(1);
    verify(() => mockBox.addAll(tFruitModelList)).called(1);
  });

  test('getInitialFruits retourne au moins un fruit', () {
    final result = dataSource.getInitialFruits();

    expect(result, isNotEmpty);
  });

  test('getFruits propage l’exception si la box lève une erreur', () async {
    // Arrange
    // On simule un problème disque / base qui fait planter box.values
    when(() => mockBox.values).thenThrow(Exception('Disk error'));

    // Act & Assert
    // dataSource.getFruits() ne doit pas avaler l’erreur,
    // on s’attend à recevoir la même exception.
    expect(
          () => dataSource.getFruits(),
      throwsA(isA<Exception>()),
    );

    verify(() => mockBox.values).called(1);
  });
}
