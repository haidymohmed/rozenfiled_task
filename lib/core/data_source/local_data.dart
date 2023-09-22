import 'dart:async';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class DbProvider {
  DbProvider();
  DbProvider._createInstance();
  int currVersion = 1;
  static final DbProvider db = DbProvider._createInstance();
  static Database? _database;

  //query to create Servers table
  String createServerTable = """
    CREATE TABLE Servers (
      id INTEGER PRIMARY KEY,
      name TEXT NOT NULL,
      domain TEXT NOT NULL,
      isDefaultServer BOOLEAN NOT NULL
    );
    """;

  //query to create Credential table
  String createCredentialTable ="""
    CREATE TABLE Credential (
      id INTEGER NOT NULL,
      userName TEXT NOT NULL,
      password TEXT NOT NULL
    );
    """;

  //get database of type Future<database>
  Future<Database> get database async {
    // if database doesn't exists, create one
    _database ??= await initializeDatabase();
    // if database exists, return database
    return _database!;
  }

  setDatabase (Database database) {
    _database = database ;
  }


  Future<Database> initializeDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'Icode.db');
    return await openDatabase(
      path,
      version: currVersion,
      onCreate: (Database db, int version) async {
        await db.execute(createServerTable);
        await db.execute(createCredentialTable);
      },
    );
  }
}
