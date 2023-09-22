

import 'package:equatable/equatable.dart';

abstract class AddUpdateDeleteServerState extends Equatable{
  // ignore: non_constant_identifier_names
  AddUpdateDeleteServerEvent();

  @override
  List<Object> get props => [];
}
class AddUpdateDeleteServerInitial extends AddUpdateDeleteServerState{
  @override
  AddUpdateDeleteServerEvent() {
    // TODO: implement AddUpdateDeleteServerEvent
    throw UnimplementedError();
  }
}
class LoadingAddUpdateDeleteServerState extends AddUpdateDeleteServerState{
  @override
  AddUpdateDeleteServerEvent() {
    // TODO: implement AddUpdateDeleteServerEvent
    throw UnimplementedError();
  }

}
class ErrorAddUpdateDeleteServerState extends AddUpdateDeleteServerState{
  final String message ;
  ErrorAddUpdateDeleteServerState({required this.message});
  @override
  AddUpdateDeleteServerEvent() {
    // TODO: implement AddUpdateDeleteServerEvent
    throw UnimplementedError();
  }
}
class MessageAddUpdateDeleteServerState extends AddUpdateDeleteServerState{
  final String message ;
  MessageAddUpdateDeleteServerState({required this.message});
  @override
  AddUpdateDeleteServerEvent() {
    // TODO: implement AddUpdateDeleteServerEvent
    throw UnimplementedError();
  }
}