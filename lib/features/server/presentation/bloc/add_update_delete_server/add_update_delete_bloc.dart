import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rozenfiled_task/core/error/failure.dart';
import 'package:rozenfiled_task/core/strings/message.dart';
import 'package:rozenfiled_task/features/server/domain/usecases/add_server_usecase.dart';
import 'package:rozenfiled_task/features/server/domain/usecases/delete_server_usecase.dart';
import 'package:rozenfiled_task/features/server/domain/usecases/update_server.dart';
import 'package:rozenfiled_task/features/server/presentation/bloc/add_update_delete_server/add_update_delete_event.dart';
import 'package:rozenfiled_task/features/server/presentation/bloc/add_update_delete_server/add_update_delete_state.dart';

class AddUpdateDeleteServerBloc extends Bloc<AddUpdateDeleteServerEvent , AddUpdateDeleteServerState>{

  final AddServerUseCase addServerUseCase;
  final DeleteServerUseCase deleteServerUseCase;
  final UpdateServerUseCase updateServerUseCase;

  AddUpdateDeleteServerBloc({
    required this.addServerUseCase,
    required this.updateServerUseCase,
    required this.deleteServerUseCase,
  }) : super (AddUpdateDeleteServerInitial()){
   on<AddUpdateDeleteServerEvent>((event , emit)async{
     if(event is AddServerEvent){
       emit(LoadingAddUpdateDeleteServerState());
       final failureOrDoneMessage = await addServerUseCase(event.server);
      emit( _getFailureOrDoneMessage( failureOrDoneMessage , ADD_SUCCESS_MESSAGE));
     }else if(event is UpdateServerEvent){
       emit(LoadingAddUpdateDeleteServerState());
       final failureOrDoneMessage = await updateServerUseCase(event.server);
       emit(_getFailureOrDoneMessage( failureOrDoneMessage , UPDATE_SUCCESS_MESSAGE));
     }else if(event is DeleteServerEvent){
       emit(LoadingAddUpdateDeleteServerState());
       final failureOrDoneMessage =  await deleteServerUseCase(event.serverId);
       emit(_getFailureOrDoneMessage( failureOrDoneMessage , DELETE_SUCCESS_MESSAGE));
     }
   });
  }

  AddUpdateDeleteServerState _getFailureOrDoneMessage(Either<Failure , Unit> failure , String message){
    return failure.fold((fail){
      return ErrorAddUpdateDeleteServerState(message: fail.message);
    }, (_){
      return MessageAddUpdateDeleteServerState(message: message);
    });
  }

}