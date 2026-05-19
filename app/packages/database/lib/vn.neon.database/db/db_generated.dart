// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members

import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'db.dart';
import 'db_dao.dart';
import 'entity/db_entity.dart';

class $FloorAppFloorDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppFloorDatabaseBuilder databaseBuilder(String name) => _$AppFloorDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppFloorDatabaseBuilder inMemoryDatabaseBuilder() => _$AppFloorDatabaseBuilder(null);
}

class _$AppFloorDatabaseBuilder {
  _$AppFloorDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppFloorDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppFloorDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppFloorDatabase> build() async {
    final path = name != null ? await sqfliteDatabaseFactory.getDatabasePath(name!) : ':memory:';
    final database = _$AppFloorDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppFloorDatabase extends AppFloorDatabase {
  _$AppFloorDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  DBDao? _dbDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations, [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE IF NOT EXISTS `DBEntity` (`path` TEXT NOT NULL, `data` TEXT NOT NULL, PRIMARY KEY (`path`))',
        );

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  DBDao get dbDao {
    return _dbDaoInstance ??= _$DBDao(database, changeListener);
  }
}

class _$DBDao extends DBDao {
  _$DBDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _dBEntityInsertionAdapter = InsertionAdapter(
          database,
          'DBEntity',
          (DBEntity item) => <String, Object?>{'path': item.path, 'data': item.data},
        );

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DBEntity> _dBEntityInsertionAdapter;

  @override
  Future<dynamic> getQuestions() async {
    return _queryAdapter.queryList(
      'SELECT data FROM DBEntity',
      mapper: (p) {
        return p;
      },
    );
  }

  @override
  Future<void> addData(DBEntity item) async {
    await _dBEntityInsertionAdapter.insert(item, OnConflictStrategy.ignore);
  }

  @override
  Future<void> replaceData(DBEntity item) async {
    await _dBEntityInsertionAdapter.insert(item, OnConflictStrategy.replace);
  }
}
