import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart' hide Table;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/fruit_model.dart';

part 'drift_database.g.dart';

/// Table Drift pour les fruits.
/// On déclare un nom de DataClass custom pour éviter les conflits
/// avec l'entité de domaine [Fruit].
@DataClassName('FruitRow')
class FruitTable extends Table {
  IntColumn get id => integer().autoIncrement()(); // PK interne
  TextColumn get externalId => text()();           // ID métier
  TextColumn get name => text()();
  TextColumn get color => text()();
  RealColumn get price => real()();
}

/// Ouverture lazy de la DB SQLite utilisée par Drift.
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'fruits_drift.db'));

    debugPrint('Drift DB path: ${file.path}');

    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(tables: [FruitTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// Méthode pratique pour récupérer tous les fruits.
  Future<List<FruitRow>> getAllFruitRows() {
    return select(fruitTable).get();
  }

  /// Remplace tout le contenu de la table par la nouvelle liste.
  Future<void> replaceAllFruits(List<FruitRow> rows) async {
    await transaction(() async {
      await delete(fruitTable).go();
      await batch((batch) {
        batch.insertAll(
          fruitTable,
          rows
              .map(
                (row) => FruitTableCompanion.insert(
              externalId: row.externalId,
              name: row.name,
              color: row.color,
              price: row.price,
            ),
          )
              .toList(),
        );
      });
    });
  }
}
