import 'package:batalha_series/models/serie_model.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class OperationsDatabase {
  static const _databaseName = "series.db";
  static const _tableName = "series";
  static const _databaseVersion = 1;

  static final OperationsDatabase _instance = OperationsDatabase._internal();

  factory OperationsDatabase() => _instance;

  OperationsDatabase._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  // Inicializa o banco de dados
  Future<Database> _initDatabase() async {
    String path = '';

    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
      path = _databaseName;
    } else {
      path = join(await getDatabasesPath(), _databaseName);
    }

    _database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );

    return _database!;
  }

  // Criação da tabela no banco
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        genero TEXT NOT NULL,
        descricao TEXT NOT NULL,
        capaUrl TEXT NOT NULL,
        pontuacao INTEGER NOT NULL
      )
    ''');
  }

  // Obtém todas as séries
  Future<List<SerieModel>> getSeries() async {
    final db = await database;

    try {
      // Consulta todas as séries no banco de dados
      final List<Map<String, dynamic>> result = await db.query(
        _tableName,
        orderBy: 'pontuacao DESC, nome ASC',
      );

      // Converte cada mapa retornado em um objeto SerieModel
      return result.map((map) => SerieModel.fromMap(map)).toList();
    } catch (e) {
      print('Erro ao obter séries: $e');
      throw Exception('Erro ao obter séries: $e');
    }
  }

  // Remove uma série pelo ID
  Future<bool> removeSerie(int idSerie) async {
    final db = await database;

    try {
      int count = await db.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [idSerie],
      );
      return count > 0; // Retorna true se alguma linha foi deletada
    } catch (e) {
      print('Erro ao remover a série: $e');
      return false;
    }
  }

  // Adiciona uma nova série
  Future<bool> addSerie(Map<String, dynamic> serieMap) async {
    final db = await database;

    try {
      await db.insert(_tableName, serieMap);
      return true;
    } catch (e) {
      print('Erro ao adicionar a série: $e');
      return false;
    }
  }

  Future<bool> updatePontuacao(SerieModel serie) async {
    final db = await database;

    // Atualiza a série no banco de dados
    int count = await db.update(
      'series',
      serie.toMap(),
      where: 'id = ?',
      whereArgs: [serie.id],
    );

    // Retorna true se a atualização for bem-sucedida (count > 0)
    return count > 0;
  }
}
