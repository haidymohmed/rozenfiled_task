import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:rozenfiled_task/features/home/presentation/lofgin_home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AnimatedSplashScreen(
          nextScreen: LoginHome(),
          splash: Image.asset("assets/images/logo.png"),
        ),
      ),
    );
  }
}
