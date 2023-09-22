import 'package:flutter/material.dart';
import 'package:rozenfiled_task/features/splash_screen/presentaion/view/splash_screen.dart';


class Rozenfiled extends StatelessWidget {
  const Rozenfiled({super.key});
  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
