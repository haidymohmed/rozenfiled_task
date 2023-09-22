// ignore_for_file: must_be_immutable
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rozenfiled_task/core/widgets/custom_toast.dart';
import 'package:rozenfiled_task/features/server/presentation/bloc/add_update_delete_server/add_update_delete_bloc.dart';
import 'package:rozenfiled_task/features/server/presentation/bloc/add_update_delete_server/add_update_delete_event.dart';
import 'package:rozenfiled_task/features/server/presentation/bloc/servers/servers_event.dart';
import 'package:rozenfiled_task/features/server/presentation/bloc/servers/servers_bloc.dart';
import 'package:rozenfiled_task/core/resources/color_manager.dart';
import 'package:rozenfiled_task/core/widgets/custom_button.dart';
import 'package:rozenfiled_task/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../bloc/add_update_delete_server/add_update_delete_state.dart';


class DeleteServerDialog extends StatelessWidget {
  int serverId ;
  var inAsyncCall = ValueNotifier<bool>(false);
  DeleteServerDialog({Key? key , required this.serverId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<AddUpdateDeleteServerBloc , AddUpdateDeleteServerState>(
        listener: (context , state){
          if(state is LoadingAddUpdateDeleteServerState){
            inAsyncCall.value = true ;
          }else if(state is MessageAddUpdateDeleteServerState){
            inAsyncCall.value = false ;
            showToastError(msg: state.message, state: ToastedStates.SUCCESS);
            BlocProvider.of<ServersBloc>(context).add(RefreshServerEvent());
            Navigator.pop(context);
          }else if(state is ErrorAddUpdateDeleteServerState){
            inAsyncCall.value = false ;
            showToastError(msg: state.message, state: ToastedStates.ERROR);
          }
        },
        child: ValueListenableBuilder(
          valueListenable: inAsyncCall,
          builder: (context , value , child){
            return ModalProgressHUD(
              inAsyncCall: inAsyncCall.value,
              child: AlertDialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                insetPadding: EdgeInsets.zero,
                contentPadding: const EdgeInsets.all(0),
                content: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  width: MediaQuery.of(context).size.width * 0.95 ,
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5
                        ),
                        decoration: const BoxDecoration(
                            color: ColorManager.primary,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                            )
                        ),
                        child: Row(
                          children: [
                            CustomText(
                              title: "Delete Server",
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Center(
                        child: CustomText(
                          title: "Are you sure you want to delete this selected server ? ",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Divider(indent: 10,endIndent: 10,thickness: 1,color: ColorManager.lightGrey),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            title: "Delete",
                            onTap: (){
                              BlocProvider.of<AddUpdateDeleteServerBloc>(context).add(DeleteServerEvent(serverId: serverId));
                            }
                          ),
                          const SizedBox(width: 10),
                          CustomButton(
                            title: "Cancle",
                            onTap: (){
                              Navigator.pop(context);
                            }
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
