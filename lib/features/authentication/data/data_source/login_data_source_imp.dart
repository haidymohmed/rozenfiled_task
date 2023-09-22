import 'dart:developer';

import 'package:rozenfiled_task/core/data_source/remote_data.dart';
import 'login_data_source.dart';

class LoginDataSourceImp extends LoginDataSource{
  ApiClientHelper apiClientHelper ;
  LoginDataSourceImp({required this.apiClientHelper});


  @override
  Future login({required String userName, required String password}) async{
    bool hasUrl = await apiClientHelper.hasUrl();
    if(hasUrl){
      return await  apiClientHelper.post(
        endPoint: "/v1/api/Authentication/login",
        data: {
          "username": userName.trim(),
          "password": password.trim() ,
          "deviceToken" : null
        }
      );
    }
  }
}