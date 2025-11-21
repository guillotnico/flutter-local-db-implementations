import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../models/fruit_model.dart';
import 'fruit_dao.dart';

part 'app_database.g.dart';

@Database(
  version: 1,
  entities: [FruitModel],
)
abstract class AppDatabase extends FloorDatabase {
  FruitDao get fruitDao;
}
