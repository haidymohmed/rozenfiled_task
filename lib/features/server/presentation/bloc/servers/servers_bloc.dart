import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rozenfiled_task/core/error/failure.dart';
import 'package:rozenfiled_task/core/strings/error.dart';
import 'package:rozenfiled_task/features/server/domain/usecases/get_servers_usecase.dart';
import 'package:rozenfiled_task/features/server/presentation/bloc/servers/servers_event.dart';
import 'package:rozenfiled_task/features/server/presentation/bloc/servers/servers_state.dart';

class ServersBloc extends Bloc<ServersEvent , ServersState>{
  final GetAllServersUseCase getAllServers ;
  ServersBloc({required this.getAllServers}) : super(ServersInitial()){
    on<ServersEvent>((event , emit) async{
       if(event is GetAllServersEvent || event is RefreshServerEvent){
         emit(LoadingServersState());
         final failureServers = await getAllServers();
         failureServers.fold(
           (failure){
             emit(ErrorServersState(message: failure.message));
           },
           (servers){
             emit(LoadedServersState(servers: servers));
           }
         );
       }
    });
  }
}