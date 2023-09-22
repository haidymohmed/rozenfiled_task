import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rozenfiled_task/core/resources/color_manager.dart';
import 'package:rozenfiled_task/core/strings/error.dart';
import 'package:rozenfiled_task/core/widgets/custom_text.dart';
import 'package:rozenfiled_task/core/widgets/custom_toast.dart';
import 'package:rozenfiled_task/features/server/domain/entities/server_model.dart';
import 'package:rozenfiled_task/features/server/presentation/bloc/add_update_delete_server/add_update_delete_bloc.dart';
import 'package:rozenfiled_task/features/server/presentation/bloc/add_update_delete_server/add_update_delete_state.dart';
import 'package:rozenfiled_task/features/server/presentation/bloc/servers/servers_bloc.dart';
import 'package:rozenfiled_task/features/server/presentation/bloc/servers/servers_event.dart';
import 'package:rozenfiled_task/features/server/presentation/bloc/servers/servers_state.dart';
import 'package:rozenfiled_task/features/server/presentation/widgets/server_widget.dart';

import 'add_server.dart';

class ServerScreen extends StatelessWidget {
  ServerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            title: "Servers",
            color: ColorManager.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          centerTitle: true,
          backgroundColor: ColorManager.primary,
        ),
        floatingActionButton: InkWell(
          onTap: (){
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => AddServerDialog(methodType: METHOD_TYPE.ADD_SERVEER)
            );
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadius.circular(50)
            ),
            child: const Icon(
                Icons.add,
              color: ColorManager.white,
            ),
          ),
        ),
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: RefreshIndicator(
              onRefresh: ()async{
                BlocProvider.of<ServersBloc>(context).add(RefreshServerEvent());
              },
              color: ColorManager.primary,
              child: BlocBuilder<ServersBloc ,ServersState>(
                builder: (context ,state){
                  if(state is LoadedServersState){
                    return ListView.separated(
                      itemCount: state.servers.length,
                      separatorBuilder: (BuildContext context, int index) => const Divider(color: ColorManager.grey,indent: 10,endIndent:  10),
                      itemBuilder: (BuildContext context, int index) {
                        return ServerWidget(
                          server: state.servers[index],
                        );
                      },
                    );
                  }else if (state is LoadingServersState){
                    return const Center(child: CircularProgressIndicator(color: ColorManager.primary));
                  }else if (state is ErrorServersState){
                    return emptyList(title: state.message);
                  }else{
                    return emptyList(title: DEFAULT_FAILURE_MESSAGE);
                  }
                },
              ),
            )
        ),
      ),
    );
  }
  emptyList({required title}){
    return Center(
      child: CustomText(
        title: title,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
