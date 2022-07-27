import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whisky_hunter/src/route/tm_route.dart';
import 'package:whisky_hunter/src/shared/app_managrer.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var isFirstOpenApp = false;

  void _getFirstOpenApp() async {
    final prefs = await SharedPreferences.getInstance();
    isFirstOpenApp = prefs.getBool(AppManager.firstOpenApp) ?? false;
  }

  @override
  void initState() {
    super.initState();
    _getFirstOpenApp();
    Future.delayed(const Duration(seconds: 5), () {
      if (isFirstOpenApp) {
        if (FirebaseAuth.instance.currentUser != null) {
          Get.offAllNamed(TMRoute.main.name!);
        } else {
          Get.offAndToNamed(TMRoute.signin.name!);
        }
      } else {
        Get.offAllNamed(TMRoute.onboarding.name!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/whiskey1.jpeg'),
            fit: BoxFit.fill,
          ),
        ),
        child: const Center(
          child: Text('WHISKY HUNTER'),
        ),
      ),
    );
  }
}
