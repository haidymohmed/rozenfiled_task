// ignore_for_file: must_be_immutable
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rozenfiled_task/core/functions/validator.dart';
import 'package:rozenfiled_task/core/widgets/custom_toast.dart';
import 'package:rozenfiled_task/features/server/domain/entities/server_model.dart';
import 'package:rozenfiled_task/features/server/presentation/bloc/add_update_delete_server/add_update_delete_bloc.dart';
import 'package:rozenfiled_task/features/server/presentation/bloc/add_update_delete_server/add_update_delete_event.dart';
import 'package:rozenfiled_task/features/server/presentation/bloc/add_update_delete_server/add_update_delete_state.dart';
import 'package:rozenfiled_task/features/server/presentation/bloc/servers/servers_bloc.dart';
import 'package:rozenfiled_task/features/server/presentation/bloc/servers/servers_event.dart';
import 'package:rozenfiled_task/features/server/presentation/widgets/server_text_form.dart';
import 'package:rozenfiled_task/core/resources/color_manager.dart';
import 'package:rozenfiled_task/core/widgets/custom_button.dart';
import 'package:rozenfiled_task/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

enum METHOD_TYPE {
  ADD_SERVEER,
  UPDATE_SERVER
}
class AddServerDialog extends StatelessWidget {
  METHOD_TYPE methodType ;
  Server? server ;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isDefault = ValueNotifier<bool>(false);
  var inAsyncCall = ValueNotifier<bool>(false);
  var serverModel = ValueNotifier<Server>(Server(id: 0, name: '', isDefaultServer: false, domain: ''));
  AddServerDialog({Key? key , required this.methodType , this.server}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(methodType == METHOD_TYPE.UPDATE_SERVER){
      serverModel.value = server!;
      isDefault.value = server!.isDefaultServer ;
    }
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
            Navigator.pop(context);
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
                              title: methodType == METHOD_TYPE.ADD_SERVEER ? "Add New Server" : "Edit Server",
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10
                          ),
                          child: Column(
                            children: [
                              ServerTextFormFiled(
                                title: "Server Name",
                                iconData: Icons.storage,
                                initialValue: serverModel.value.name,
                                validator: (String? value) => value.isValid(),
                                onSaved: (String? value) => serverModel.value.name = value.notNull(),
                              ),
                              ServerTextFormFiled(
                                title: "Server IP / Domain",
                                iconData: Icons.link,
                                initialValue: serverModel.value.domain,
                                validator: (String? value) => value.isDomainValid(),
                                onSaved: (String? value) => serverModel.value.domain = value.notNull(),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.check_circle , size: 20),
                                        const SizedBox(width: 10),
                                        CustomText(title: "Default Server"),
                                      ],
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable: isDefault,
                                      builder: (context , value , child){
                                        return Checkbox(
                                            value: isDefault.value,
                                            activeColor: ColorManager.primary,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            onChanged:(bool? newValue){
                                              isDefault.value = newValue!;
                                            }
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(indent: 10,endIndent: 10,thickness: 1,color: ColorManager.lightGrey),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                              title: "Save",
                              onTap: (){
                                if(formKey.currentState?.validate() == true){
                                  formKey.currentState?.save();
                                  serverModel.value.isDefaultServer = isDefault.value;
                                  if(methodType == METHOD_TYPE.ADD_SERVEER){
                                    BlocProvider.of<AddUpdateDeleteServerBloc>(context).add(AddServerEvent(server: serverModel.value));
                                  }
                                  else if(methodType == METHOD_TYPE.UPDATE_SERVER){
                                    BlocProvider.of<AddUpdateDeleteServerBloc>(context).add(UpdateServerEvent(server: serverModel.value));
                                  }

                                }
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
