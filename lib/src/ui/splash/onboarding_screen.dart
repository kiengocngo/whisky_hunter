import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:whisky_hunter/src/route/tm_route.dart';
import 'package:whisky_hunter/src/shared/app_managrer.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Center(
            child: Text('On Boarding'),
          ),
          InkWell(
            onTap: () {
              _setFirstOpenApp();
              Get.offAllNamed(TMRoute.signin.name!);
            },
            child: const Center(
              child: Text('Next Screen'),
            ),
          )
        ],
      ),
    );
  }

  void _setFirstOpenApp() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(AppManager.firstOpenApp, true);
  }
}
