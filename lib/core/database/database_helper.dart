import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = 'wellness_app.db';
  static const _databaseVersion = 1;
  static const _tableName = 'offerings';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        practitionerName TEXT NOT NULL,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        category TEXT NOT NULL,
        duration TEXT NOT NULL,
        type TEXT NOT NULL,
        price REAL NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');
  }

  Future<int> insert(Map<String, dynamic> data) async {
    Database db = await database;
    return await db.insert(_tableName, data);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await database;
    return await db.query(_tableName, orderBy: 'createdAt DESC');
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    Database db = await database;
    return await db.update(_tableName, data, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await database;
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}