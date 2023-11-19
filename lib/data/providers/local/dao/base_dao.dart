import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'base_model.dart';

abstract class AppBaseDao<T> {
  Future<T?> findById(dynamic id, {String idKey = 'id'});

  Future<List<T>> findAll();

  Future<int> save(T data);
  Future<int> saveWith(T data, Database database);
  Future<void> saveAll(List<T> data);

  Future<int> update(T data);
  // Future<int> updateWith(T data, Database database);
  Future<void> updateAll(List<T> data);

  Future<int> deleteById(dynamic id, {String idKey = 'id'});

  Future<void> drop();

  Future<void> clear();
}

abstract class AppBaseDaoImpl<T extends AppBaseModel> extends AppBaseDao<T> {
  AppBaseDaoImpl({required this.sqlite, required this.tableName});

  @protected
  String tableName;

  @protected
  Database sqlite;

  T jsonToEntity(Map<String, Object?> json);

  @override
  Future<int> deleteById(dynamic id, {String idKey = 'id'}) async {
    return sqlite.delete(tableName, where: '$idKey = ?', whereArgs: [id]);
  }

  @override
  Future<void> drop() {
    return sqlite.execute('DROP TABLE $tableName;');
  }

  @override
  Future<List<T>> findAll() async {
    final result = await sqlite.query(tableName);
    return result.map(jsonToEntity.call).toList();
  }

  @override
  Future<T?> findById(dynamic id, {String idKey = 'id'}) async {
    final result = await sqlite.query(
      tableName,
      where: '$idKey = ?',
      whereArgs: [id],
      // limit: 1,
    );
    return result.isEmpty ? null : jsonToEntity(result.first);
  }

  @override
  Future<int> save(T data) async {
    return saveWith(data, sqlite);
  }

  @override
  Future<int> saveWith(T data, Database database) async {
    return database.insert(
      tableName,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> saveAll(List<T> data) {
    return sqlite.transaction<void>((txn) {
      final batch = txn.batch();
      for (final element in data) {
        batch.insert(
          tableName,
          element.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      return batch.commit();
    });
  }

  @override
  Future<int> update(T data) async {
    return updateWith(data, sqlite);
  }

  Future<int> updateWith(T data, Database database) async {
    return database.update(
      tableName,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateAll(List<T> data) async {
    return sqlite.transaction((txn) {
      final batch = txn.batch();
      for (final element in data) {
        batch.update(
          tableName,
          element.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      return batch.commit();
    });
  }

  @override
  Future<void> clear() async {
    await sqlite.delete(tableName);
  }
}
