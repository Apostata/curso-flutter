
import 'package:sqflite/sqflite.dart' as SQL;
import 'package:path/path.dart' as path;

class DdUtil {
  //ddl data definition language
  static Future<SQL.Database> database() async {
    final dbPath = await SQL.getDatabasesPath();
    return SQL.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE places (id TEXT PRIMARY KEY, title TEXT, image TEXT)');
      }, //quando criado pela primeira vez
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DdUtil.database();
    await db.insert(table, data,
        conflictAlgorithm: SQL.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DdUtil.database();
    return db.query(table);
  }

  static Future<void> remove(String table, String id) async {
    final db = await DdUtil.database();
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
    // return getData(table);
  }
}
