import 'package:flutter_test/flutter_test.dart';
import 'package:hive_implementation/features/fruits/domain/usecases/get_all_fruits.dart';
import 'package:hive_implementation/features/fruits/presentation/providers/fruit_provider.dart';
import 'package:mocktail/mocktail.dart';


import '../../fixtures/fruit_fixtures.dart';

class MockGetAllFruitsUseCase extends Mock
    implements GetAllFruitsUseCase {}

void main() {
  late FruitProvider provider;
  late MockGetAllFruitsUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetAllFruitsUseCase();
    provider = FruitProvider(getAllFruitsUseCase: mockUseCase);
  });

  void logSection(String title) {
    print('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    print('🧪 $title');
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  }

  void logStep(String message) {
    print('   👉 $message');
  }

  test('loadFruits met à jour isLoading, fruits et errorMessage', () async {
    logSection('FruitProvider: loadFruits() succès');

    when(() => mockUseCase())
        .thenAnswer((_) async => tFruitList);

    logStep('On appelle loadFruits().');
    final future = provider.loadFruits();

    expect(provider.isLoading, true);

    await future;

    logStep('On vérifie l’état final du provider.');
    expect(provider.isLoading, false);
    expect(provider.errorMessage, isNull);
    expect(provider.fruits, equals(tFruitList));

    print('✅ FruitProvider: scénario succès OK');
  });

}
