import 'package:rozenfiled_task/core/data_source/local_data.dart';
import 'package:rozenfiled_task/features/authentication/data/models/login_credintial.dart';

class CredentialDatabaseHelper {
  late DbProvider dbProvider;

  CredentialDatabaseHelper( {required this.dbProvider}) ;

  static const table = 'Credential';
  static const columnId = 'id';
  static const columnName = 'userName';
  static const columnIPassword = 'password';
  Future<int> insertOrUpdateRecord(LoginCredential credential) async {
    final db = await dbProvider.database;
    final existingRecord = await db.query(table, where: 'id = ?', whereArgs: [1]);

    if (existingRecord.isNotEmpty) {
      return update(credential);
    }else{
      return insert(credential);
    }
  }
  Future<int> insert(LoginCredential credential) async {
    final db = await dbProvider.database;
    return await db.rawInsert(""
        'INSERT INTO $table($columnId , $columnName,  $columnIPassword) VALUES( 1, "${credential.userName}", "${credential.password}")'
        "");
  }

  Future<int> update(LoginCredential credential) async {
    final db = await dbProvider.database;
    return await db.update(
      table,
      credential.toJson(),
      where: '$columnId = ?',
      whereArgs: [1],
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
  Future<List<Map<String, Object?>>> checkCredential({required String userName, required String password}) async {
    final db = await dbProvider.database;
    return await db.rawQuery(
        "SELECT * FROM $table "
            "WHERE $columnName = '$userName' and $columnIPassword = '$password'");
  }
  Future<List<Map<String, dynamic>>> getCredential() async {
    final db = await dbProvider.database;
    return await db.query(
      table,
      where: '$columnId = ?',
      whereArgs: [1],
    );
  }
}