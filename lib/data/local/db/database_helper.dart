import 'dart:io' show Directory;

import 'package:meta/meta.dart' show protected, required;
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;
import 'package:sqflite/sqflite.dart' show Database, openDatabase;
import 'package:sqflite/sqflite.dart';

abstract class DatabaseHelper {
  /// Stores version of the SQLite database
  int _version;

  @protected
  Database database;

  /// Stores name of the SQLite database
  String _name;

  DatabaseHelper({
    @required final String name,
    @required final int version,
  })  : this._name = name.contains('.db') ? name : '$name.db',
        this._version = version;

  Future<Database> init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _name);
    return await openDatabase(
      path,
      version: _version,
      onOpen: onOpen,
      onCreate: onCreate,
      onUpgrade: onUpgrade,
      onDowngrade: onDowngrade,
    );
  }

  Future<void> execute(String query, [List<dynamic> arguments]);

  Future<void> batchExecute(List<String> queries);

  Future<int> insert(String table, Map<String, dynamic> values,
      {String nullColumnHack, ConflictAlgorithm conflictAlgorithm});

  Future<int> update(String table, Map<String, dynamic> values,
      {String where,
      List<dynamic> whereArgs,
      ConflictAlgorithm conflictAlgorithm});

  Future<int> delete(String table, {String where, List<dynamic> whereArgs});

  Future<List<Map<String, dynamic>>> rawQuery(String query,
      [List<dynamic> arguments]);

  Future<List<int>> batchInsert(
      String table, List<Map<String, dynamic>> valueList,
      {ConflictAlgorithm conflictAlgorithm});

  Future<List<int>> batchUpsert(
      String table, List<Map<String, dynamic>> valueList);

  Future<int> upsert(String table, Map<String, dynamic> values,
      {String nullColumnHack});

  @protected
  Future<void> onCreate(Database db, int version);

  @protected
  Future<void> onOpen(Database db) async {}

  @protected
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion);

  @protected
  Future<void> onDowngrade(Database db, int oldVersion, int newVersion);

  Future<void> clear() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _name);
    if (await databaseExists(path)) {
      return deleteDatabase(path);
    }
  }

  void close();
}
