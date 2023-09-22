
import 'package:rozenfiled_task/features/authentication/domain/repository/login_repository.dart';
import 'package:rozenfiled_task/core/error/failure.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase {
  LoginRepository loginRepository ;
  LoginUseCase({required this.loginRepository});

  Future<Either<Failure , int>> call({required String userName, required String password}){
    return loginRepository.login(userName: userName, password: password);
  }
}