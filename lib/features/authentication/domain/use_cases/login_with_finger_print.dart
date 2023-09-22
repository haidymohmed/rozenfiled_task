
import 'package:rozenfiled_task/features/authentication/domain/repository/login_repository.dart';
import 'package:rozenfiled_task/core/error/failure.dart';
import 'package:dartz/dartz.dart';

class LoginWithFingerPrintUseCase {
  LoginRepository loginRepository ;
  LoginWithFingerPrintUseCase({required this.loginRepository});

  Future<Either<Failure , int>> call(){
    return loginRepository.loginWithFingerPrint();
  }
}