import 'package:dartz/dartz.dart';
import 'package:rozenfiled_task/features/server/domain/entities/server_model.dart';
import 'package:rozenfiled_task/features/server/domain/repository/repository.dart';
import '../../../../core/error/failure.dart';

class UpdateServerUseCase{
  final ServerRepository repository;
  UpdateServerUseCase(this.repository);
  Future<Either<Failure , Unit>> call (Server server) async{
    return await repository.updateServer(server);
  }
}