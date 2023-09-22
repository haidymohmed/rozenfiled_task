import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rozenfiled_task/features/server/data/data_source/server_data_source.dart';
import 'package:rozenfiled_task/features/server/data/models/server.dart';
import 'package:rozenfiled_task/features/server/domain/entities/server_model.dart';

class ApiClientHelper{
  static late Dio mainDio ;
  ServerDatabaseHelper databaseHelper ;
  String url = "";
  ApiClientHelper({required this.databaseHelper});
  static init(){
    mainDio = Dio();
  }
  Future<bool> hasUrl() async {
    var response =await  databaseHelper.getDefaultServer();
    if(response.isNotEmpty){
      ServerModel server = ServerModel.fromJson(response.first);
      url = server.domain;
      return true ;
    }else{
      return false ;
    }
  }
  Future post({data, endPoint , headers , queryParameters}){
    return mainDio.post(
      url + endPoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: headers
      )
    );
  }
}