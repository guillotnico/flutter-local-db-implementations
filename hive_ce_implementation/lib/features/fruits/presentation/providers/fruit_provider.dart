// PRESENTATION LAYER - PROVIDER (State management)

import 'package:flutter/foundation.dart';
import '../../domain/entities/fruit.dart';
import '../../domain/usecases/get_all_fruits.dart';

class FruitProvider extends ChangeNotifier {
  final GetAllFruitsUseCase getAllFruitsUseCase;

  FruitProvider({required this.getAllFruitsUseCase});

  List<Fruit> _fruits = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Fruit> get fruits => _fruits;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadFruits() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await getAllFruitsUseCase();
      _fruits = result;
    } catch (e) {
      _errorMessage = 'Error while loading fruits: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
