import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();

  factory AppDatabase() => _instance;

  AppDatabase._internal();

  Database? _db;

  /// Store Sembast pour les fruits.
  final StoreRef<String, Map<String, dynamic>> fruitStore =
  stringMapStoreFactory.store('fruits');

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _openDb();
    return _db!;
  }

  Future<Database> _openDb() async {
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(dir.path, 'fruits_sembast.db');

    // Log pratique pour retrouver le fichier
    // (pour l’ouvrir ensuite dans un éditeur/VSCode)
    // ignore: avoid_print
    print('Sembast DB path: $dbPath');

    final db = await databaseFactoryIo.openDatabase(dbPath);
    return db;
  }
}
