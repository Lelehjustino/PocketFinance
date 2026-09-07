import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  // Retorna o banco.
  // Se ele ainda não existir, cria.
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('financeiro.db');

    return _database!;
  }

  // Inicializa o banco
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Criação das tabelas
  Future<void> _createDB(Database db, int version) async {

    // Tabela de categorias
    await db.execute('''
      CREATE TABLE categorias (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        icone TEXT NOT NULL,
        cor TEXT NOT NULL
      )
    ''');

    // Tabela de transações
    await db.execute('''
      CREATE TABLE transacoes (
        id TEXT PRIMARY KEY,
        nome TEXT NOT NULL,
        valor REAL NOT NULL,
        data TEXT NOT NULL,
        receita INTEGER NOT NULL,
        categoria_id INTEGER NOT NULL,
        descricao TEXT,

        FOREIGN KEY (categoria_id)
          REFERENCES categorias(id)
      )
    ''');

    // Categorias iniciais
    await db.insert('categorias', {
      'nome': 'Alimentação',
      'icone': 'Alimentação',
      'cor': '0xFFE57373',
    });

    await db.insert('categorias', {
      'nome': 'Transporte',
      'icone': 'Transporte',
      'cor': '0xFF81C784',
    });

    await db.insert('categorias', {
      'nome': 'Moradia',
      'icone': 'Moradia',
      'cor': '0xFF9575CD',
    });

    await db.insert('categorias', {
      'nome': 'Saúde',
      'icone': 'Saúde',
      'cor': '0xFF64B5F6',
    });

    await db.insert('categorias', {
      'nome': 'Educação',
      'icone': 'Educação',
      'cor': '0xFFFFB74D',
    });

    await db.insert('categorias', {
      'nome': 'Lazer',
      'icone': 'Lazer',
      'cor': '0xFFBA68C8',
    });

    await db.insert('categorias', {
      'nome': 'Outros',
      'icone': 'Outros',
      'cor': '0xFFDCE775',
    });
  }

  Future<void> apagarTodasTransacoes() async {
    final db = await instance.database;

    await db.delete('transacoes');
  }
}