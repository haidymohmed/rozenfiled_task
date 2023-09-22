import 'package:flutter/material.dart';
import 'package:rozenfiled_task/core/resources/color_manager.dart';
import 'package:rozenfiled_task/core/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  String title ;
  var onTap ;
  CustomButton({super.key , this.onTap , required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 5,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 2
        ),
        decoration: BoxDecoration(
          color: ColorManager.primary,
          borderRadius: BorderRadius.circular(5)
        ),
        child: Center(
          child: CustomText(
            title: title,
            fontWeight:   FontWeight.w600,
            color: ColorManager.white,
            fontSize: 15,
          ),
        )
      ),
    );
  }
}
