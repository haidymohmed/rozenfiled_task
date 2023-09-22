import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rozenfiled_task/core/data_source/local_data.dart';
import 'package:rozenfiled_task/core/network/network_info_imp.dart';
import 'package:rozenfiled_task/core/data_source/remote_data.dart';
import 'package:rozenfiled_task/core/network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:rozenfiled_task/features/authentication/data/data_source/credintial_data_base.dart';
import 'package:rozenfiled_task/features/authentication/data/data_source/login_data_source.dart';
import 'package:rozenfiled_task/features/authentication/data/data_source/login_data_source_imp.dart';
import 'package:rozenfiled_task/features/authentication/data/repository/login_repository_imp.dart';
import 'package:rozenfiled_task/features/authentication/domain/repository/login_repository.dart';
import 'package:rozenfiled_task/features/authentication/domain/use_cases/login_usecase.dart';
import 'package:rozenfiled_task/features/authentication/domain/use_cases/login_with_finger_print.dart';
import 'package:rozenfiled_task/features/authentication/domain/use_cases/set_credential.dart';
import 'package:rozenfiled_task/features/authentication/presentation/bloc/login_bloc.dart';
import 'package:rozenfiled_task/features/server/data/data_source/server_data_source.dart';
import 'package:rozenfiled_task/features/server/data/repository/server_repository_imp.dart';
import 'package:rozenfiled_task/features/server/domain/repository/repository.dart';
import 'package:rozenfiled_task/features/server/domain/usecases/add_server_usecase.dart';
import 'package:rozenfiled_task/features/server/domain/usecases/delete_server_usecase.dart';
import 'package:rozenfiled_task/features/server/domain/usecases/get_servers_usecase.dart';
import 'package:rozenfiled_task/features/server/domain/usecases/update_server.dart';
import 'package:rozenfiled_task/features/server/presentation/bloc/add_update_delete_server/add_update_delete_bloc.dart';
import 'package:rozenfiled_task/features/server/presentation/bloc/servers/servers_bloc.dart';

final sl = GetIt.instance;

init(){
  //Bloc
  sl.registerFactory(() => ServersBloc(getAllServers: sl()));
  sl.registerFactory(() => LoginBloc(loginUseCase: sl(),setLoginCredentialUseCase: sl() , loginWithFingerPrintUseCase: sl()));
  sl.registerFactory(() => AddUpdateDeleteServerBloc(addServerUseCase: sl(), deleteServerUseCase: sl(), updateServerUseCase: sl()));

  //UseCases
  sl.registerLazySingleton(() => GetAllServersUseCase(sl()));
  sl.registerLazySingleton(() => AddServerUseCase(sl()));
  sl.registerLazySingleton(() => UpdateServerUseCase(sl()));
  sl.registerLazySingleton(() => DeleteServerUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(loginRepository :sl()));
  sl.registerLazySingleton(() => LoginWithFingerPrintUseCase(loginRepository :sl()));
  sl.registerLazySingleton(() => SetLoginCredentialUseCase(loginRepository :sl()));

  //Repository
  sl.registerLazySingleton<ServerRepository>(() => ServerRepositoryImpl(
    databaseHelper: sl(),
  ));
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImp(
    dataSource: sl(),
    networkInfo: sl(),
    databaseHelper: sl()
  ));


  //DataSource
  sl.registerLazySingleton<LoginDataSource>(() => LoginDataSourceImp(
    apiClientHelper: sl(),
  ));


  //core
  sl.registerLazySingleton(() => ApiClientHelper(databaseHelper: sl()));
  sl.registerLazySingleton(() => ServerDatabaseHelper(dbProvider: sl()));
  sl.registerLazySingleton(() => CredentialDatabaseHelper(dbProvider: sl()));
  sl.registerLazySingleton(() => DbProvider());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(internetConnectionChecker: sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
}