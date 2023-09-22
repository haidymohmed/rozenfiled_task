import 'package:equatable/equatable.dart';

class Failure extends Equatable{
  String message ;
  int code ;
  Failure({required this.message , required this.code});

  @override
  List<Object?> get props => [message];
}
