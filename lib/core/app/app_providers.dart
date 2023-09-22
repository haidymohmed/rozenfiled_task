import 'package:provider/single_child_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rozenfiled_task/features/authentication/presentation/bloc/login_bloc.dart';
import 'package:rozenfiled_task/features/server/presentation/bloc/add_update_delete_server/add_update_delete_bloc.dart';
import 'package:rozenfiled_task/features/server/presentation/bloc/servers/servers_bloc.dart';
import 'package:rozenfiled_task/features/server/presentation/bloc/servers/servers_event.dart';
import 'injection_controller.dart' as di;

class AppProviders {
  static List<SingleChildWidget> get(){
    return [
      BlocProvider(create: (_) => di.sl<ServersBloc>()..add(GetAllServersEvent())),
      BlocProvider(create: (_) => di.sl<AddUpdateDeleteServerBloc>()),
      BlocProvider(create: (_) => di.sl<LoginBloc>()),
    ];
  }
}