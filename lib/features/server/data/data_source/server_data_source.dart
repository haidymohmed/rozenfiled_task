import 'package:rozenfiled_task/core/data_source/local_data.dart';
import 'package:rozenfiled_task/features/server/data/models/server.dart';
import 'package:sqflite/sqflite.dart';



class ServerDatabaseHelper {
  late DbProvider dbProvider;

  ServerDatabaseHelper({required this.dbProvider}) {
    dbProvider = DbProvider();
  }

  static const table = 'Servers';
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnIsDefault = 'isDefaultServer';
  static const columnDomain = 'domain';

  Future<int> insert(ServerModel serverModel) async {
    final db = await dbProvider.database;
    if (serverModel.isDefaultServer == true) {
      await db.update(table, {columnIsDefault: 0});
    }
    return await db.rawInsert(""
        'INSERT INTO $table($columnName, $columnDomain, $columnIsDefault) VALUES("${serverModel.name}", "${serverModel.domain}", ${serverModel.isDefaultServer == true? 1 : 0 })'
        "");
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    final db = await dbProvider.database;
    return await db.query(table);
  }

  Future<int> queryRowCount() async {
    final db = await dbProvider.database;
    final results = await db.rawQuery('SELECT COUNT(*) FROM $table');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  Future<int> update(ServerModel serverModel) async {
    final db = await dbProvider.database;
    if (serverModel.isDefaultServer == true) {
      await db.update(table, {columnIsDefault: 0});
    }
    int id = serverModel.id;
    return await db.update(
      table,
      serverModel.toJson(),
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;
    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
  Future<List<Map<String, dynamic>>> getDefaultServer() async {
    final db = await dbProvider.database;
    return await db.query(
      table,
      where: '$columnIsDefault = ?',
      whereArgs: [1],
    );
  }
}