import 'package:rozenfiled_task/core/error/failure.dart';
import 'package:rozenfiled_task/features/server/domain/entities/server_model.dart';
import 'package:dartz/dartz.dart';

abstract class ServerRepository {
  Future<Either<Failure , List<Server>>> getAllServers();
  Future<Either<Failure , Unit>> deleteServer(int id);
  Future<Either<Failure , Unit>> updateServer(Server server);
  Future<Either<Failure , Unit>> insertServer(Server server);
}