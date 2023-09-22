import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rozenfiled_task/core/resources/color_manager.dart';
import 'package:rozenfiled_task/core/widgets/custom_text.dart';
import 'package:rozenfiled_task/features/server/domain/entities/server_model.dart';
import 'package:rozenfiled_task/features/server/presentation/bloc/add_update_delete_server/add_update_delete_bloc.dart';
import 'package:rozenfiled_task/features/server/presentation/bloc/add_update_delete_server/add_update_delete_event.dart';
import 'package:rozenfiled_task/features/server/presentation/pages/add_server.dart';
import 'package:rozenfiled_task/features/server/presentation/widgets/delete_server_dialog.dart';

class ServerWidget extends StatelessWidget {
  Server server ;
  ServerWidget({super.key , required this.server});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getSection(
                title: "Server Name",
                value: server.name
              ),
              Row(
                children: [
                  getIcon(
                    iconData: Icons.edit,
                    color: ColorManager.primary,
                    onTap: (){
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AddServerDialog(methodType: METHOD_TYPE.UPDATE_SERVER , server: server)
                      );
                    }
                  ),
                  const SizedBox(width: 10),
                  getIcon(
                    iconData: Icons.delete,
                    color: ColorManager.rose,
                    onTap: (){
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => DeleteServerDialog(serverId: server.id)
                      );
                    }
                  ),
                ],
              )
            ],
          ),
          getSection(
            title: "Server IP / Domain",
            value: server.domain
          ),
          getSection(
            title: "Default Server",
            value: server.isDefaultServer.toString()
          ),
        ],
      ),
    );
  }
  getSection({required String title , required String value}){
    return Row(
      children: [
        CustomText(
          title: "$title : ",
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        CustomText(
          title:  value,
          fontWeight: FontWeight.normal,
          fontSize: 15,
        ),
      ],
    );
  }
  getIcon({required  IconData iconData , var onTap , required Color color}){
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color
        ),
        child: Icon(
          iconData,
          color: ColorManager.white,
        ),
      ),
    );
  }
}
