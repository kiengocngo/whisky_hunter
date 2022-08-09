import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whisky_hunter/src/constant/tm_icon.dart';
import 'package:whisky_hunter/src/data/model/boarding_model.dart';
import 'package:whisky_hunter/src/route/tm_route.dart';
import 'package:whisky_hunter/src/shared/app_managrer.dart';
import 'package:get/get.dart';
import 'package:whisky_hunter/theme/tm_colors.dart';
import 'package:whisky_hunter/theme/tm_theme_data.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final List<BoardingModel> listBoarding = [
    BoardingModel(TMIcons.whisky1, 'whisky hunter title 1'),
    BoardingModel(TMIcons.whisky2, 'whisky hunter title 2'),
    BoardingModel(TMIcons.whisky3, 'whisky hunter title 3'),
  ];
  int currentPage = 0;
  late Timer timer;
  PageController pageController = PageController(
    initialPage: 0,
  );
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 5), (Timer timer1) {
      if (currentPage < 2) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      pageController.animateToPage(currentPage,
          duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: PageView.builder(
              controller: pageController,
              itemCount: listBoarding.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(listBoarding[index].imgUrl),
                          fit: BoxFit.fill),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                          child: Text(
                            listBoarding[index].title,
                            style:
                                TMThemeData.fromContext(context).textNameWhisky,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    _setFirstOpenApp();
                    Get.offAllNamed(TMRoute.main.name!);
                  },
                  child: Container(
                    height: 56,
                    width: 240,
                    decoration: BoxDecoration(
                      gradient: TMColors.gradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          tr('skip'),
                          style: TMThemeData.fromContext(context)
                              .textNameWhiskyBlack,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(Icons.skip_next),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _setFirstOpenApp() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(AppManager.firstOpenApp, true);
  }
}
