import 'package:equatable/equatable.dart';
import 'package:rozenfiled_task/features/server/domain/entities/server_model.dart';

abstract class AddUpdateDeleteServerEvent extends Equatable{
  const AddUpdateDeleteServerEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddServerEvent extends AddUpdateDeleteServerEvent{
  final Server server ;
  const AddServerEvent({required this.server});
  @override
  List<Object?> get props => [server];
}

class UpdateServerEvent extends AddUpdateDeleteServerEvent{
  final Server server ;
  const UpdateServerEvent({required this.server});
  @override
  List<Object?> get props => [server];
}

class DeleteServerEvent extends AddUpdateDeleteServerEvent{
  final int serverId ;
  const DeleteServerEvent({required this.serverId});
  @override
  List<Object?> get props => [serverId];
}
