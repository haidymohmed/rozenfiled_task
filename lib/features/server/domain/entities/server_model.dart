

import 'package:equatable/equatable.dart';

class Server extends Equatable{
  int id ;
  String name , domain;
  bool isDefaultServer ;
  Server({required this.id , required this.name , required this.isDefaultServer , required this.domain});

  @override
  // TODO: implement props
  List<Object?> get props => [id , name , domain , isDefaultServer];
}