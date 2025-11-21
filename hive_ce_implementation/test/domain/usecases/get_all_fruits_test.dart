import 'package:flutter_test/flutter_test.dart';
import 'package:hive_implementation/features/fruits/domain/repositories/fruit_repository.dart';
import 'package:hive_implementation/features/fruits/domain/usecases/get_all_fruits.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/fruit_fixtures.dart';

class MockFruitRepository extends Mock implements FruitRepository {}

void main() {
  late GetAllFruitsUseCase useCase;
  late MockFruitRepository mockRepository;

  setUp(() {
    mockRepository = MockFruitRepository();
    useCase = GetAllFruitsUseCase(mockRepository);
  });

  test('devrait retourner la liste de fruits depuis le repository', () async {
    // arrange
    when(() => mockRepository.getAllFruits())
        .thenAnswer((_) async => tFruitList);

    // act
    final result = await useCase();

    // assert
    expect(result, tFruitList);
    verify(() => mockRepository.getAllFruits()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
