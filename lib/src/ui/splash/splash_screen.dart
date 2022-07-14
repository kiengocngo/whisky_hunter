import 'package:flutter/material.dart';
import 'package:whisky_hunter/src/route/tm_route.dart';
import 'package:whisky_hunter/src/shared/app_managrer.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _goToNextScreen() async {
    bool isFirstTimeOpenApp = await Get.find<AppManager>().isFirstTimeOpenApp();
    
    TMRoute nextRoute = isFirstTimeOpenApp ? TMRoute.auction : TMRoute.main;
    Get.offAllNamed(nextRoute.name!);
  }


  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 1), () => {_goToNextScreen()});
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
      ),
    );
  }
}
