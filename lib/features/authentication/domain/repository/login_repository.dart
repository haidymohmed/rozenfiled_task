import 'package:rozenfiled_task/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<Failure , int>> login({required String userName, required String password});
  Future<Either<Failure , int>> loginWithFingerPrint();
  Future<Either<Failure , String>> setFingerPrint({required String userName, required String password});
}