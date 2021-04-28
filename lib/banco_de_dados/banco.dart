import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class SQLDatabase {
  /// Conectar no banco de dados
  static Future<Database> get database async {
    final dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(path.join(dbPath, 'data.db'),
        onConfigure: _onConfigure, version: 1, onCreate: (db, version) async {
      await db
          .execute(
              'CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, nome TEXT, email TEXT, senha TEXT)')
          .then((value) => _creatingDb(db));
    });
  }

  /// Ordenando a execução de operações assíncronas
  static _creatingDb(db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS conta (id INTEGER PRIMARY KEY, user_id INTEGER, dia_pagamento TEXT, titulo TEXT, descricao TEXT, pago INTEGER, FOREIGN KEY (user_id) REFERENCES users(id))');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS ultimo_login (id INTEGER PRIMARY KEY, user_id INTEGER, FOREIGN KEY (user_id) REFERENCES users(id))');
  }

  /// Ligando as chaves estrangeiras
  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  /// Inserir no banco de dados
  static Future<int> insert(String table, Map<String, dynamic> data) async {
    final sqlDb = await SQLDatabase.database;
    return sqlDb.insert(table, data,
        conflictAlgorithm: ConflictAlgorithm.abort);
  }

  /// Ler um dado do banco
  static Future<List<Map<String, dynamic>>> read(String table) async {
    final sqlDb = await SQLDatabase.database;
    return sqlDb.query(table);
  }

  /// Deletar um elemento do banco
  static Future<int> delete(String table, int id) async {
    final sqlDb = await SQLDatabase.database;
    return sqlDb.delete(table, where: 'id=?', whereArgs: [id]);
  }
}
