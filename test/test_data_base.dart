import 'package:rozenfiled_task/features/server/data/data_source/server_data_source.dart';
import 'package:rozenfiled_task/features/server/data/models/server.dart';
import 'package:rozenfiled_task/core/data_source/local_data.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';


class DioAdapterMock extends Mock implements HttpClientAdapter {}

Future main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  const MethodChannel channel = MethodChannel('plugins.flutter.io/path_provider');
  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    return ".";
  });

  var databaseFactory = databaseFactoryFfi;
  var db = await databaseFactory.openDatabase(inMemoryDatabasePath);

  DbProvider dbProvider = DbProvider();
  await db.execute(dbProvider.createServerTable);
  dbProvider.setDatabase(db);

  ServerDatabaseHelper serverDatabaseHelper= ServerDatabaseHelper(dbProvider: dbProvider);
  group("Test Server DataBase", () {
    test('Successful Insert Should return 1', () async {
      await serverDatabaseHelper.insert(ServerModel(id: 1, name: "Domain", isDefaultServer: true, domain: "https://icodesuite.com/icodecrnapi"));
      await serverDatabaseHelper.insert(ServerModel(id: 2, name: "Test", isDefaultServer: false, domain: "https://icodesuite.com"));
      var p = await db.query("Servers");
      const expectedResponse = 2;
      expect(p.length, equals(expectedResponse));
    });

    test('Successful Update Should return 1', () async {
      await serverDatabaseHelper.update(ServerModel(id: 1, name: "CCN", isDefaultServer: true, domain: "https://icodesuite.com/icodecrnapi"));
      var p = await db.query("Servers");
      const updateResponse = "CCN";
      expect(p.first["name"], equals(updateResponse));
    });

    test('Successful Delete Should return 1', () async {
      await serverDatabaseHelper.delete(2);
      var p = await db.query("Servers");
      const deleteResponse = 1;
      expect(p.length, equals(deleteResponse));
    });

    test('Successful delete un found id Should return list length 1', () async {
      await serverDatabaseHelper.delete(100);
      var p = await db.query("Servers");
      const deleteResponse = 1;
      expect(p.length, equals(deleteResponse));
    });

    test('Successful UnFound id Should return 0', () async {
      final response = await serverDatabaseHelper.getDefaultServer();
      expect(response.first["domain"], equals("https://icodesuite.com/icodecrnapi"));
    });
  });

}