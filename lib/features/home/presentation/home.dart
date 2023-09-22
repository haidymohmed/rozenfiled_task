

import 'package:flutter/material.dart';
import 'package:rozenfiled_task/core/widgets/custom_text.dart';
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: CustomText(
            title: "Welcom to Home",
          ),
        ),
      ),
    );
  }
}
