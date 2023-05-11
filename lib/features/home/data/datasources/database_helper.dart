import 'package:music_player_flutter/features/home/data/model/music_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/music_favourite.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  static const String _tblFavourite = 'favourite';

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblFavourite (
        id INTEGER PRIMARY KEY,
        artist TEXT,
        url TEXT,
        cover TEXT,
        title TEXT,
        trackTimeMillis INTEGER,
        artistUrl TEXT,
        releaseDate TEXT,
        longDescription TEXT
      );
    ''');
  }

  Future<int> insertFavourite(MusicTable table) async {
    final db = await database;
    return await db!.insert(_tblFavourite, table.toJson());
  }

  Future<int> removeFavourite(MusicTable table) async {
    final db = await database;
    return await db!.delete(_tblFavourite, where: 'id = ?', whereArgs: [table.id]);
  }

  Future<Map<String, dynamic>?> getFavoriteById(int? id) async {
    final db = await database;
    final results = await db!.query(_tblFavourite, where: 'id = ?', whereArgs: [id]);

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getFavouriteList() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblFavourite);
    return results;
  }
}
