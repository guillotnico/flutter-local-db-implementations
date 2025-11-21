import 'package:objectbox/objectbox.dart';

import '../models/fruit_model.dart'; // importe aussi objectbox.g.dart via `part`
import '../../../../objectbox.g.dart';
/// Wrapper pour le Store ObjectBox et la Box<FruitModel>.
class ObjectBoxStore {
  late final Store store;
  late final Box<FruitModel> fruitBox;

  ObjectBoxStore._create(this.store) {
    fruitBox = store.box<FruitModel>();
  }

  /// Crée et ouvre le Store ObjectBox.
  static Future<ObjectBoxStore> create() async {
    // ⚠️ `openStore()` est une FONCTION générée dans objectbox.g.dart
    //     ce n'est PAS une méthode de ObjectBoxStore.
    final store = await openStore();
    return ObjectBoxStore._create(store);
  }

  void close() {
    store.close();
  }
}
