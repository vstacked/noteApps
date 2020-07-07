import 'dart:io';

import 'package:note_apps/models/note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseServices {
  static Database _database;

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'note.db';

    var noteDb = openDatabase(path, version: 1, onCreate: _createDb);
    return noteDb;
  }

  void _createDb(Database db, int ver) async {
    await db.execute('''
    CREATE TABLE note(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      note TEXT,
      date TEXT
    )
    ''');
    print('Database was created!');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

  Future<int> insert(Note obj) async {
    Database db = await this.database;
    int count = await db.insert('note', obj.toMap());
    return count;
  }

  Future<int> update(Note obj) async {
    Database db = await this.database;
    int count = await db
        .update('note', obj.toMap(), where: 'id=?', whereArgs: [obj.id]);
    return count;
  }

  Future<int> delete(int id) async {
    Database db = await this.database;
    int count = await db.delete('note', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<Note> getNoteOrderById(int id) async {
    Database db = await this.database;
    Future<List<Map<String, dynamic>>> count =
        db.query('note', where: 'id=?', whereArgs: [id]);
    var data = await count;
    if (data.length != 0) {
      return Note.fromMap(data.first);
    }
    return null;
  }

  Future<List<Note>> getNoteAllData() async {
    Database db = await this.database;
    List<Map<String, dynamic>> mapList =
        await db.query('note', orderBy: 'date');
    int count = mapList.length;
    List<Note> noteList = List<Note>();
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMap(mapList[i]));
    }
    return noteList;
  }
}
