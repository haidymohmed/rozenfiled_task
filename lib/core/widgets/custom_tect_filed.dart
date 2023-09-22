import 'dart:developer';

import 'package:rozenfiled_task/core/resources/color_manager.dart';
import 'package:rozenfiled_task/core/resources/font_manager.dart';
import 'package:rozenfiled_task/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomTextFormFiled extends StatelessWidget {
  String title , initialValue ;
  String? icon ;
  bool password ;
  int minLines ;
  Widget? suffix ;
  double margin ;
  IconData iconData ;
  var validator , onSaved ,onChanged;
  var isSecure = ValueNotifier<bool>(true);
  final isValid = ValueNotifier<bool>(true);

  CustomTextFormFiled({Key? key  ,required this.title  , this.initialValue = "", required this.iconData ,
    this.password = false ,required this.validator , this.margin = 15,this.onChanged,
    this.onSaved , this.minLines = 1 ,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: margin,
            vertical: 10
          ),
          child: ValueListenableBuilder<bool>(
            valueListenable: isSecure,
            builder: (context , value , child) {
              return TextFormField(
                style: const TextStyle(
                    fontFamily: FontManager.cairo
                ),
                onSaved: onSaved,
                minLines: minLines,
                maxLines: minLines,
                onChanged: onChanged,
                validator: (String? value){
                  if(validator(value) == null){
                    isValid.value = true;
                  }else{
                    isValid.value = false;
                  }
                  return validator(value);
                },
                initialValue: initialValue,
                obscureText: password == true ? isSecure.value : password ,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: ColorManager.white,
                  errorStyle: const TextStyle(
                    fontFamily: FontManager.cairo,
                    fontWeight: FontWeight.w700,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
                  focusedErrorBorder: outLineBordr(color: Colors.red),
                  errorBorder: outLineBordr(color: Colors.red),
                  enabledBorder:outLineBordr(),
                  border: outLineBordr(),
                  focusedBorder: outLineBordr(),
                  disabledBorder: outLineBordr(),
                  suffix: password == false ? null : InkWell(
                    onTap: (){
                      isSecure.value = ! isSecure.value ;
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5
                      ),
                      child: Icon(
                        isSecure.value == false ? Icons.visibility_off : Icons.visibility,
                        color: ColorManager.grey900,
                      ),
                    ),
                  ),
                  label: ValueListenableBuilder<bool>(
                    valueListenable: isValid,
                    builder: (context , child , state){
                      return Row(
                        children: [
                          Icon(
                            iconData ,
                            color: child == true ? ColorManager.primary : ColorManager.red
                          ),
                          const SizedBox(width: 5),
                          CustomText(
                            title: title ,
                            color: child == true ? ColorManager.primary : ColorManager.red,
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      );
                    },
                  ),
                  hintStyle:  const TextStyle(
                    fontFamily: FontManager.cairo,
                  ),
                ),
              );
            }
          ),
        )
      ],
    );
  }

  outLineBordr({color}){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color ?? ColorManager.lightGrey , width: 1),
    );
  }
}
