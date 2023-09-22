import 'package:dartz/dartz.dart';
import 'package:rozenfiled_task/features/server/domain/repository/repository.dart';
import '../../../../core/error/failure.dart';

class DeleteServerUseCase{
  final ServerRepository repository;
  DeleteServerUseCase(this.repository);
  Future<Either<Failure , Unit>> call (int id) async{
    return await repository.deleteServer(id);
  }
}