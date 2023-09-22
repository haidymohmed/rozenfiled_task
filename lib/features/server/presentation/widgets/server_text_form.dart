import 'package:rozenfiled_task/core/resources/color_manager.dart';
import 'package:rozenfiled_task/core/resources/font_manager.dart';
import 'package:rozenfiled_task/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ServerTextFormFiled extends StatelessWidget {
  String title , initialValue ;
  String? icon ;
  double margin ;
  IconData iconData ;
  var validator , onSaved ,onChanged;
  final isValid = ValueNotifier<bool>(true);
  ServerTextFormFiled({Key? key  ,required this.title  , this.initialValue = "", required this.iconData ,
    required this.validator , this.margin = 15,this.onChanged, this.onSaved }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
          fontFamily: FontManager.cairo
      ),
      onSaved: onSaved,
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
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorManager.white,
        errorStyle: const TextStyle(height: 0),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
        focusedErrorBorder: outLineBordr(color: Colors.red),
        errorBorder: outLineBordr(color: Colors.red),
        enabledBorder:outLineBordr(),
        border: outLineBordr(),
        focusedBorder: outLineBordr(),
        disabledBorder: outLineBordr(),
        label: ValueListenableBuilder<bool>(
          valueListenable: isValid,
          builder: (context , child , state){
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  fontSize: 14,
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

  outLineBordr({color}){
    return UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color ?? ColorManager.lightGrey , width: 2),
    );
  }
}
