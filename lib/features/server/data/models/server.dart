import 'package:rozenfiled_task/features/server/domain/entities/server_model.dart';


class ServerModel extends Server {
  ServerModel({required super.id, required super.name, required super.isDefaultServer, required super.domain});
  factory ServerModel.fromJson(Map<String , dynamic> json){
    return ServerModel(id: json['id'] , name: json['name'], domain: json['domain'] , isDefaultServer: json['isDefaultServer'] == 1 ? true : false);
  }
  toJson(){
    return {
      "id" : id,
      "name" : name,
      "domain" : domain,
      "isDefaultServer" : isDefaultServer == true ? 1 : 0,
    };
  }
}