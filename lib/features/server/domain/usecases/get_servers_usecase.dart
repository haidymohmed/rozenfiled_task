import 'package:dartz/dartz.dart';
import 'package:rozenfiled_task/features/server/domain/entities/server_model.dart';
import 'package:rozenfiled_task/features/server/domain/repository/repository.dart';
import '../../../../core/error/failure.dart';

class GetAllServersUseCase{
  final ServerRepository repository;
  GetAllServersUseCase(this.repository);
  Future<Either<Failure , List<Server>>> call () async{
    return await repository.getAllServers();
  }
}