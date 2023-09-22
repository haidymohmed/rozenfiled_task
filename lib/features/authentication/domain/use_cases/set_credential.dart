
import 'package:rozenfiled_task/features/authentication/domain/repository/login_repository.dart';
import 'package:rozenfiled_task/core/error/failure.dart';
import 'package:dartz/dartz.dart';

class SetLoginCredentialUseCase {
  LoginRepository loginRepository ;
  SetLoginCredentialUseCase({required this.loginRepository});

  Future<Either<Failure, String>> call({required String userName, required String password}){
    return loginRepository.setFingerPrint(userName: userName, password: password);
  }
}