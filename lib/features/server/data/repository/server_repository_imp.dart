import 'package:rozenfiled_task/core/strings/error.dart';
import 'package:rozenfiled_task/features/server/data/data_source/server_data_source.dart';
import 'package:rozenfiled_task/features/server/domain/entities/server_model.dart';
import 'package:rozenfiled_task/features/server/domain/repository/repository.dart';
import 'package:rozenfiled_task/features/server/data/models/server.dart';
import 'package:rozenfiled_task/core/error/failure.dart';
import 'package:dartz/dartz.dart';

class ServerRepositoryImpl extends ServerRepository {
  ServerDatabaseHelper databaseHelper ;
  ServerRepositoryImpl({required this.databaseHelper});

  @override
  Future<Either<Failure, Unit>> deleteServer(int id) async {
    try{
      final response = await databaseHelper.delete(id);
      if(response > 0){
        return const Right(unit);
      }else{
        return Left(Failure(message: DEFAULT_FAILURE_MESSAGE , code: 0));
      }
    }on Exception{
      return Left(Failure(message: DEFAULT_FAILURE_MESSAGE , code: 0));
    }
  }

  @override
  Future<Either<Failure, List<Server>>> getAllServers() async {
    try{
      final localServers = await databaseHelper.queryAllRows();
      List<Server> servers = [];
      for (var element in localServers) {
        ServerModel serverModel = ServerModel.fromJson(element);
        servers.add(serverModel);
      }
      if(servers.isNotEmpty){
        return Right(servers);
      }else{
        return Left(Failure(message: EMPTY_CACHE_FAILURE_MESSAGE , code: 0));
      }
    }on Exception{
      return Left(Failure(message: DEFAULT_FAILURE_MESSAGE , code: 0));
    }
  }

  @override
  Future<Either<Failure, Unit>> insertServer(Server server) async {
    try{
      final ServerModel serverModel = ServerModel(id: server.id, name: server.name, isDefaultServer: server.isDefaultServer , domain: server.domain);
      final response = await databaseHelper.insert(serverModel);
      if(response > 0){
        return const Right(unit);
      }else{
        return Left(Failure(message: DEFAULT_FAILURE_MESSAGE , code: 0));
      }
    }on Exception{
      return Left(Failure(message: DEFAULT_FAILURE_MESSAGE , code: 0));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateServer(Server server) async {
    try{
      final ServerModel serverModel = ServerModel(id: server.id, name: server.name, isDefaultServer: server.isDefaultServer , domain: server.domain);
      final response = await databaseHelper.update(serverModel);
      if(response > 0){
        return const Right(unit);
      }else{
        return Left(Failure(message: DEFAULT_FAILURE_MESSAGE , code: 0));
      }
    }on Exception{
      return Left(Failure(message: DEFAULT_FAILURE_MESSAGE , code: 0));
    }
  }
  
  
}