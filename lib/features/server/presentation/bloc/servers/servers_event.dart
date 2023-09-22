import 'package:equatable/equatable.dart';

abstract class ServersEvent extends Equatable{
  const ServersEvent();
  @override
  List<Object> get props => [];
}
class GetAllServersEvent extends  ServersEvent{}
class RefreshServerEvent extends ServersEvent{}