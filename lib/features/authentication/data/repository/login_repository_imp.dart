import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:rozenfiled_task/core/functions/validator.dart';
import 'package:rozenfiled_task/core/model/custom_response.dart';
import 'package:rozenfiled_task/core/network/network_info.dart';
import 'package:rozenfiled_task/core/strings/error.dart';
import 'package:rozenfiled_task/features/authentication/data/data_source/credintial_data_base.dart';
import 'package:rozenfiled_task/features/authentication/data/data_source/login_data_source.dart';
import 'package:rozenfiled_task/features/authentication/data/models/login_credintial.dart';
import 'package:rozenfiled_task/features/authentication/data/models/login_response.dart';
import 'package:rozenfiled_task/features/authentication/domain/repository/login_repository.dart';
import 'package:rozenfiled_task/core/error/failure.dart';
import 'package:dartz/dartz.dart';

class LoginRepositoryImp extends LoginRepository{
  NetworkInfo networkInfo ;
  LoginDataSource dataSource ;
  CredentialDatabaseHelper databaseHelper ;
  LoginRepositoryImp({required this.dataSource , required this.networkInfo , required this.databaseHelper});
  @override
  Future<Either<Failure, int>> login({required String userName, required String password}) async {
    if(await networkInfo.isConnected){
      try{
        Response? response = await dataSource.login(userName: userName, password: password);
        if(response == null){
          return Left(Failure(message: "No Default Server Added Please add a default server", code: -1));
        }else{
          if(response.statusCode == 200){
            CustomResponse<Resource> registerResponse = CustomResponse<Resource>
                .fromJson(response.data, (json) => Resource.fromJson(json));
            if(registerResponse.status == 1){
              var checkCredential = await  databaseHelper.checkCredential(userName: userName , password: password);
              if(checkCredential.isNotEmpty){ //not empty
                return const Right(1);
              }else{
                return const Right(0);
              }
            }else{
              return Left(Failure(message: registerResponse.message.notNull() ,code: 0));
            }
          }else{
            return Left(Failure(message: response.statusMessage.notNull() ,code: 0));
          }
        }
      }on DioException catch(e){
        return Left(Failure(message: DEFAULT_FAILURE_MESSAGE , code: 0));
      }
    }else{
      return Left(Failure(message: "No Internet Connections" , code: 0));
    }
  }

  @override
  Future<Either<Failure, int>> loginWithFingerPrint() async{
    try{
      var response = await fingerPrint();
      if(response == null){
        List getCredential = await databaseHelper.getCredential();
        if(getCredential.isNotEmpty){
          LoginCredential credential = LoginCredential.fromJson(getCredential.first);
          return login(userName: credential.userName.notNull(), password: credential.password.notNull());
        }else{
          return Left(Failure(message: "No Fingerprint saved , you need to login with your credential first then scan your fingerprint" , code: 0));
        }
      }else{
        return Left(Failure(message: response , code: 0));
      }

    }on DioException {
      return Left(Failure(message: DEFAULT_FAILURE_MESSAGE , code: 0));
    }
  }

  @override
  Future<Either<Failure, String>> setFingerPrint({required String userName, required String password}) async {
    try{
      var response = await fingerPrint();
      if(response == null){
        int saved = await databaseHelper.insertOrUpdateRecord(LoginCredential(id: 1 , userName: userName , password: password));
        if(saved > 0){
          return const Right("Fingerprint saved Successfully");
        }else{
          return Left(Failure(message: DEFAULT_FAILURE_MESSAGE , code: 0));
        }
      }
      else{
        return Left(Failure(message: response , code: 0));
      }
    }on DioException {
      return Left(Failure(message: DEFAULT_FAILURE_MESSAGE , code: 0));
    }
  }

  Future<String?> fingerPrint() async {
    final LocalAuthentication auth = LocalAuthentication();
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    if(canAuthenticate){
      try {
        final bool didAuthenticate = await auth.authenticate(
            localizedReason: 'Please authenticate to save login',
            options: const AuthenticationOptions(useErrorDialogs: false),
        );
        if(didAuthenticate){
          return null;
        }else{
          return DEFAULT_FAILURE_MESSAGE;
        }
      } on PlatformException catch (e) {
        return DEFAULT_FAILURE_MESSAGE;
      }
    }else{
      return "Your mobile doest support fingerprint";
    }
  }
}