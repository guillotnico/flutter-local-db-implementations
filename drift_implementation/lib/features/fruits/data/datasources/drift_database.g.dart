// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $FruitTableTable extends FruitTable
    with TableInfo<$FruitTableTable, FruitRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FruitTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _externalIdMeta = const VerificationMeta(
    'externalId',
  );
  @override
  late final GeneratedColumn<String> externalId = GeneratedColumn<String>(
    'external_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, externalId, name, color, price];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fruit_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<FruitRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('external_id')) {
      context.handle(
        _externalIdMeta,
        externalId.isAcceptableOrUnknown(data['external_id']!, _externalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_externalIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FruitRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FruitRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      externalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}external_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
    );
  }

  @override
  $FruitTableTable createAlias(String alias) {
    return $FruitTableTable(attachedDatabase, alias);
  }
}

class FruitRow extends DataClass implements Insertable<FruitRow> {
  final int id;
  final String externalId;
  final String name;
  final String color;
  final double price;
  const FruitRow({
    required this.id,
    required this.externalId,
    required this.name,
    required this.color,
    required this.price,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['external_id'] = Variable<String>(externalId);
    map['name'] = Variable<String>(name);
    map['color'] = Variable<String>(color);
    map['price'] = Variable<double>(price);
    return map;
  }

  FruitTableCompanion toCompanion(bool nullToAbsent) {
    return FruitTableCompanion(
      id: Value(id),
      externalId: Value(externalId),
      name: Value(name),
      color: Value(color),
      price: Value(price),
    );
  }

  factory FruitRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FruitRow(
      id: serializer.fromJson<int>(json['id']),
      externalId: serializer.fromJson<String>(json['externalId']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<String>(json['color']),
      price: serializer.fromJson<double>(json['price']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'externalId': serializer.toJson<String>(externalId),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<String>(color),
      'price': serializer.toJson<double>(price),
    };
  }

  FruitRow copyWith({
    int? id,
    String? externalId,
    String? name,
    String? color,
    double? price,
  }) => FruitRow(
    id: id ?? this.id,
    externalId: externalId ?? this.externalId,
    name: name ?? this.name,
    color: color ?? this.color,
    price: price ?? this.price,
  );
  FruitRow copyWithCompanion(FruitTableCompanion data) {
    return FruitRow(
      id: data.id.present ? data.id.value : this.id,
      externalId: data.externalId.present
          ? data.externalId.value
          : this.externalId,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
      price: data.price.present ? data.price.value : this.price,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FruitRow(')
          ..write('id: $id, ')
          ..write('externalId: $externalId, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, externalId, name, color, price);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FruitRow &&
          other.id == this.id &&
          other.externalId == this.externalId &&
          other.name == this.name &&
          other.color == this.color &&
          other.price == this.price);
}

class FruitTableCompanion extends UpdateCompanion<FruitRow> {
  final Value<int> id;
  final Value<String> externalId;
  final Value<String> name;
  final Value<String> color;
  final Value<double> price;
  const FruitTableCompanion({
    this.id = const Value.absent(),
    this.externalId = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.price = const Value.absent(),
  });
  FruitTableCompanion.insert({
    this.id = const Value.absent(),
    required String externalId,
    required String name,
    required String color,
    required double price,
  }) : externalId = Value(externalId),
       name = Value(name),
       color = Value(color),
       price = Value(price);
  static Insertable<FruitRow> custom({
    Expression<int>? id,
    Expression<String>? externalId,
    Expression<String>? name,
    Expression<String>? color,
    Expression<double>? price,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (externalId != null) 'external_id': externalId,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (price != null) 'price': price,
    });
  }

  FruitTableCompanion copyWith({
    Value<int>? id,
    Value<String>? externalId,
    Value<String>? name,
    Value<String>? color,
    Value<double>? price,
  }) {
    return FruitTableCompanion(
      id: id ?? this.id,
      externalId: externalId ?? this.externalId,
      name: name ?? this.name,
      color: color ?? this.color,
      price: price ?? this.price,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (externalId.present) {
      map['external_id'] = Variable<String>(externalId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FruitTableCompanion(')
          ..write('id: $id, ')
          ..write('externalId: $externalId, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FruitTableTable fruitTable = $FruitTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [fruitTable];
}

typedef $$FruitTableTableCreateCompanionBuilder =
    FruitTableCompanion Function({
      Value<int> id,
      required String externalId,
      required String name,
      required String color,
      required double price,
    });
typedef $$FruitTableTableUpdateCompanionBuilder =
    FruitTableCompanion Function({
      Value<int> id,
      Value<String> externalId,
      Value<String> name,
      Value<String> color,
      Value<double> price,
    });

class $$FruitTableTableFilterComposer
    extends Composer<_$AppDatabase, $FruitTableTable> {
  $$FruitTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FruitTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FruitTableTable> {
  $$FruitTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FruitTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FruitTableTable> {
  $$FruitTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);
}

class $$FruitTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FruitTableTable,
          FruitRow,
          $$FruitTableTableFilterComposer,
          $$FruitTableTableOrderingComposer,
          $$FruitTableTableAnnotationComposer,
          $$FruitTableTableCreateCompanionBuilder,
          $$FruitTableTableUpdateCompanionBuilder,
          (FruitRow, BaseReferences<_$AppDatabase, $FruitTableTable, FruitRow>),
          FruitRow,
          PrefetchHooks Function()
        > {
  $$FruitTableTableTableManager(_$AppDatabase db, $FruitTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FruitTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FruitTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FruitTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> externalId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> color = const Value.absent(),
                Value<double> price = const Value.absent(),
              }) => FruitTableCompanion(
                id: id,
                externalId: externalId,
                name: name,
                color: color,
                price: price,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String externalId,
                required String name,
                required String color,
                required double price,
              }) => FruitTableCompanion.insert(
                id: id,
                externalId: externalId,
                name: name,
                color: color,
                price: price,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FruitTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FruitTableTable,
      FruitRow,
      $$FruitTableTableFilterComposer,
      $$FruitTableTableOrderingComposer,
      $$FruitTableTableAnnotationComposer,
      $$FruitTableTableCreateCompanionBuilder,
      $$FruitTableTableUpdateCompanionBuilder,
      (FruitRow, BaseReferences<_$AppDatabase, $FruitTableTable, FruitRow>),
      FruitRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FruitTableTableTableManager get fruitTable =>
      $$FruitTableTableTableManager(_db, _db.fruitTable);
}
