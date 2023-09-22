import 'package:rozenfiled_task/features/authentication/data/data_source/credintial_data_base.dart';
import 'package:rozenfiled_task/features/authentication/data/data_source/login_data_source_imp.dart';
import 'package:rozenfiled_task/features/authentication/data/models/login_credintial.dart';
import 'package:rozenfiled_task/features/authentication/data/repository/login_repository_imp.dart';
import 'package:rozenfiled_task/features/server/data/data_source/server_data_source.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rozenfiled_task/features/server/data/models/server.dart';
import 'package:rozenfiled_task/core/network/network_info_imp.dart';
import 'package:rozenfiled_task/core/data_source/remote_data.dart';
import 'package:rozenfiled_task/core/data_source/local_data.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';


Future<void> main() async {
  sqfliteFfiInit();

  var databaseFactory = databaseFactoryFfi;
  var db = await databaseFactory.openDatabase(inMemoryDatabasePath);

  DbProvider dbProvider = DbProvider();
  await db.execute(dbProvider.createServerTable);
  await db.execute(dbProvider.createCredentialTable);
  dbProvider.setDatabase(db);

  ServerDatabaseHelper serverDatabaseHelper= ServerDatabaseHelper(dbProvider: dbProvider);
  CredentialDatabaseHelper credentialDatabaseHelper = CredentialDatabaseHelper(dbProvider: dbProvider);
  ApiClientHelper.init();
  late LoginRepositoryImp loginRepositoryImp =
  LoginRepositoryImp(
      databaseHelper: credentialDatabaseHelper,
      dataSource: LoginDataSourceImp(apiClientHelper: ApiClientHelper(databaseHelper: serverDatabaseHelper)),
      networkInfo: NetworkInfoImp(internetConnectionChecker: InternetConnectionChecker())
  );


  group("Test Login Logic", () {
    test('Successful Insert Should return 1', () async {
      await serverDatabaseHelper.insert(ServerModel(id: 1,
        name: "Domain",
        isDefaultServer: true,
        domain: "https://icodesuite.com/icodecrnapi"));
      var p = await db.query("Servers");
      const expectedResponse = 1;
      expect(p.length, equals(expectedResponse));
    });
    test('Successful login should return Right(0) because no the login credential is saved on database', () async {
      const expectedResponse = Right(0);

      const userName = 'jsmith';
      const password = '123456';

      final response = await loginRepositoryImp.login(
          userName: userName, password: password);

      expect(response, equals(expectedResponse));
    });
    test('Successful Insert Should return 1', () async {
      await credentialDatabaseHelper.insert(LoginCredential(
        id: 1,
        userName: "jsmith",
        password: "123456"
      ));
      var p = await db.query("Credential");
      const expectedResponse = 1;
      expect(p.length, equals(expectedResponse));
    });

    test('Successful login should return Right(1) because the login credential is saved on database', () async {
      const expectedResponse = Right(1);

      const userName = 'jsmith';
      const password = '123456';

      final response = await loginRepositoryImp.login(
          userName: userName, password: password);

      expect(response, equals(expectedResponse));
    });
  });
}
