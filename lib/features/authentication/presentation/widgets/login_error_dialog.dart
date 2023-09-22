// ignore_for_file: must_be_immutable
import 'package:rozenfiled_task/features/server/presentation/bloc/add_update_delete_server/add_update_delete_bloc.dart';
import 'package:rozenfiled_task/features/server/presentation/bloc/add_update_delete_server/add_update_delete_event.dart';
import 'package:rozenfiled_task/core/resources/color_manager.dart';
import 'package:rozenfiled_task/core/widgets/custom_button.dart';
import 'package:rozenfiled_task/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';



class LoginErrorDialog extends StatelessWidget {
  String title , body ;
  var onYes , onNo , ok ;
  LoginErrorDialog({Key? key , required this.title ,required this.body , this.onNo , this.onYes , this.ok}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
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
                      title: title,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Center(
                  child: CustomText(
                    title: body,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const Divider(indent: 10,endIndent: 10,thickness: 1,color: ColorManager.lightGrey),
              const SizedBox(height: 5),
              ok == null ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                      title: "Yes",
                      onTap: onYes
                  ),
                  const SizedBox(width: 10),
                  CustomButton(
                      title: "No",
                      onTap: onNo
                  ),
                ],
              )  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    title: "Ok",
                    onTap: ok
                  ),
                ]
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
