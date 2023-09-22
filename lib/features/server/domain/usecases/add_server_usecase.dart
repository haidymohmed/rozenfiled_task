import 'package:dartz/dartz.dart';
import 'package:rozenfiled_task/features/server/domain/entities/server_model.dart';
import 'package:rozenfiled_task/features/server/domain/repository/repository.dart';
import '../../../../core/error/failure.dart';

class AddServerUseCase{
  final ServerRepository repository;
  AddServerUseCase(this.repository);
  Future<Either<Failure , Unit>> call (Server server) async{
    return await repository.insertServer(server);
  }
}