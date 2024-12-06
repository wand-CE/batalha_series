import 'package:batalha_series/models/serie_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class OperationsDatabase {
  static const _databaseName = "series.db";
  static const _tableName = "series";
  static const _databaseVersion = 1;

  static Database? _database;

  // Inicializa o banco de dados
  Future<Database> _initDatabase() async {
    if (_database != null) {
      return _database!;
    }

    String path = join(await getDatabasesPath(), _databaseName);
    await deleteDatabase(path);

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
        pontuacao REAL NOT NULL
      )
    ''');
  }

  // Obtém todas as séries
  Future<List<SerieModel>> getSeries() async {
    final db = await _initDatabase();

    try {
      // Consulta todas as séries no banco de dados
      final List<Map<String, dynamic>> result = await db.query(_tableName);
      print(result);

      // Converte cada mapa retornado em um objeto SerieModel
      return result.map((map) => SerieModel.fromMap(map)).toList();
    } catch (e) {
      print('Erro ao obter séries: $e');
      throw Exception('Erro ao obter séries: $e');
    }
  }

  // Remove uma série pelo ID
  Future<bool> removeSerie(int idSerie) async {
    final db = await _initDatabase();

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
    final db = await _initDatabase();

    try {
      await db.insert(_tableName, serieMap);
      return true;
    } catch (e) {
      print('Erro ao adicionar a série: $e');
      return false;
    }
  }
}
