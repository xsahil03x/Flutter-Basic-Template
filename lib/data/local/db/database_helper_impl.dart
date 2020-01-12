import 'dart:core';

import 'package:flutter_template/data/local/db/database_contract.dart';
import 'package:flutter_template/data/local/db/database_helper.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperImpl extends DatabaseHelper {
  Database _database;

  DatabaseHelperImpl({
    @required String databaseName,
    @required int databaseVersion,
  }) : super(
          name: databaseName,
          version: databaseVersion,
        );

  @override
  Future<Database> init() async {
    return _database ??= await super.init();
  }

  @override
  Future<void> onCreate(Database db, int version) async {
    logMessage('Creating all tables...');
    final batch = db.batch();
    batch.execute(ItemContract.CREATE_TABLE);
    await batch.commit(noResult: false);
    logMessage('Table Creation completed...');
  }

  @override
  Future<int> delete(String table, {String where, List whereArgs}) {
    return _database.delete(table, where: where, whereArgs: whereArgs);
  }

  @override
  Future<void> execute(String query, [List arguments]) {
    return _database.execute(query, arguments);
  }

  @override
  Future<void> batchExecute(List<String> queries) async {
    final batch = _database.batch();
    for (final query in queries) {
      batch.execute(query);
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<int> insert(
    String table,
    Map<String, dynamic> values, {
    String nullColumnHack,
    ConflictAlgorithm conflictAlgorithm = ConflictAlgorithm.abort,
  }) {
    return _database.insert(
      table,
      values,
      nullColumnHack: nullColumnHack,
      conflictAlgorithm: conflictAlgorithm,
    );
  }

  @override
  Future<List<int>> batchInsert(
    String table,
    List<Map<String, dynamic>> valueList, {
    ConflictAlgorithm conflictAlgorithm = ConflictAlgorithm.abort,
  }) async {
    final batch = _database.batch();
    for (final value in valueList) {
      batch.insert(
        table,
        value,
        conflictAlgorithm: conflictAlgorithm,
      );
    }
    final result = (await batch.commit(noResult: false)).cast<int>();
    return result;
  }

  @override
  Future<List<int>> batchUpsert(
    String table,
    List<Map<String, dynamic>> valueList,
  ) async {
    final batch = _database.batch();
    for (final value in valueList) {
      batch.insert(
        table,
        value,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    final result = (await batch.commit(noResult: false)).cast<int>();
    return result;
  }

  @override
  Future<int> upsert(
    String table,
    Map<String, dynamic> values, {
    String nullColumnHack,
  }) {
    return insert(
      table,
      values,
      nullColumnHack: nullColumnHack,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> rawQuery(String query, [List arguments]) {
    return _database.rawQuery(query, arguments);
  }

  @override
  Future<int> update(
    String table,
    Map<String, dynamic> values, {
    String where,
    List whereArgs,
    ConflictAlgorithm conflictAlgorithm = ConflictAlgorithm.abort,
  }) {
    return _database.update(
      table,
      values,
      where: where,
      whereArgs: whereArgs,
      conflictAlgorithm: conflictAlgorithm,
    );
  }

  @override
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    // TODO: implement onUpgrade
    logMessage('onUpgrade');
    return null;
  }

  @override
  Future<void> onDowngrade(Database db, int oldVersion, int newVersion) async {
    // TODO: implement onDowngrade
    logMessage('onDowngrade');
    return null;
  }

  @override
  void close() {
    if (_database != null) {
      _database.close();
      _database = null;
    }
  }
}
