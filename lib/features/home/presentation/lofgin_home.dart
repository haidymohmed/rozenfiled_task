import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:rozenfiled_task/core/resources/color_manager.dart';
import 'package:rozenfiled_task/core/widgets/custom_text.dart';
import 'package:rozenfiled_task/features/authentication/presentation/view/login.dart';
import 'package:rozenfiled_task/features/server/presentation/pages/server_screen.dart';

class LoginHome extends StatefulWidget {

  LoginHome({super.key});

  @override
  State<LoginHome> createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  final _currentIndex = ValueNotifier<int>(0);
  late final PageController _pageController  = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SizedBox.expand(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  _currentIndex.value = index;
                },
                children: [
                  LoginScreen(),
                  ServerScreen()
                ],
              ),
            ),
          ),
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            padding: EdgeInsets.symmetric(
              vertical: 10
            ),
            decoration: BoxDecoration(color: ColorManager.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getBottomIcon(
                    index: 0,
                    title: "Login",
                    activeIcon: Icons.person,
                ),
                getBottomIcon(
                    index: 1,
                    title: "Servers",
                    activeIcon: Icons.storage
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getBottomIcon({title, index, activeIcon}){
    return  ValueListenableBuilder<int>(
        valueListenable: _currentIndex,
        builder: (context , state , child) {
          return InkWell(
            onTap: () {
              _currentIndex.value = index;
              _pageController.jumpToPage(index);
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5 ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    activeIcon,
                    size: 20,
                    color: _currentIndex.value == index ? ColorManager.primary : Colors.grey,
                  ),
                  SizedBox(
                    child: CustomText(
                      title: title,
                      fontSize: 14,
                      color: _currentIndex.value == index ? ColorManager.primary : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}

