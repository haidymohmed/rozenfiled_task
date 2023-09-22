import 'package:equatable/equatable.dart';
import 'package:rozenfiled_task/features/server/domain/entities/server_model.dart';

abstract class ServersState extends Equatable{
  const ServersState();
  @override
  List<Object> get props => [];
}
class ServersInitial extends  ServersState{}
class LoadingServersState extends ServersState{}
class LoadedServersState extends ServersState{
  final List<Server> servers ;
  const LoadedServersState({required this.servers});
}
// ignore: must_be_immutable
class ErrorServersState extends ServersState{
  String message ;
  ErrorServersState({required this.message});
  @override
  List<Object> get props => [message];
}