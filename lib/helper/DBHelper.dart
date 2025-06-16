import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/task_model.dart';
class DBHelper {
  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  static Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'tasks.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            priority TEXT
          )
        ''');
      },
    );
  }

  static Future<int> insert(Task task) async {
    return (await db).insert('tasks', task.toMap());
  }

  static Future<List<Task>> getTasks() async {
    final List<Map<String, dynamic>> maps = await (await db).query('tasks');
    return maps.map((e) => Task.fromMap(e)).toList();
  }

  static Future<int> update(Task task) async {
    return (await db).update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<int> delete(int id) async {
    return (await db).delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
