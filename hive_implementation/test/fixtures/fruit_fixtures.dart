

import 'package:hive_implementation/features/fruits/data/models/fruit_model.dart';
import 'package:hive_implementation/features/fruits/domain/entities/fruit.dart';

const tFruitApple = Fruit(
  id: '1',
  name: 'Apple',
  color: 'Red',
  price: 1.5,
);

const tFruitBanana = Fruit(
  id: '2',
  name: 'Banana',
  color: 'Yellow',
  price: 0.99,
);

const tFruitOrange = Fruit(
  id: '3',
  name: 'Orange',
  color: 'Orange',
  price: 1.2,
);

const tFruitGrapes = Fruit(
  id: '4',
  name: 'Grapes',
  color: 'Purple',
  price: 2.8,
);

const tFruitKiwi = Fruit(
  id: '5',
  name: 'Kiwi',
  color: 'Green',
  price: 1.1,
);

const List<Fruit> tFruitList = [
  tFruitApple,
  tFruitBanana,
  tFruitOrange,
  tFruitGrapes,
  tFruitKiwi,
];

final tFruitModelApple = FruitModel(
  id: '1',
  name: 'Apple',
  color: 'Red',
  price: 1.5,
);

final tFruitModelBanana = FruitModel(
  id: '2',
  name: 'Banana',
  color: 'Yellow',
  price: 0.99,
);

final tFruitModelOrange = FruitModel(
  id: '3',
  name: 'Orange',
  color: 'Orange',
  price: 1.2,
);

final tFruitModelGrapes = FruitModel(
  id: '4',
  name: 'Grapes',
  color: 'Purple',
  price: 2.8,
);

final tFruitModelKiwi = FruitModel(
  id: '5',
  name: 'Kiwi',
  color: 'Green',
  price: 1.1,
);

final List<FruitModel> tFruitModelList = [
  tFruitModelApple,
  tFruitModelBanana,
  tFruitModelOrange,
  tFruitModelGrapes,
  tFruitModelKiwi,
];
