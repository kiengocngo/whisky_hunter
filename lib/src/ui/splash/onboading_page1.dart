import 'package:flutter/material.dart';
import 'package:whisky_hunter/theme/tm_theme_data.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 80.0,
          ),
          const Image(
            image: AssetImage('lib/assets/images/whiskey.jpeg'),
            width: 140,
            height: 140,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 18,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Quyen loi',
              style: TMThemeData.fromContext(context).textOnboarding,
              textAlign: TextAlign.center,
              textScaleFactor: 1.0, 
            ),
          ),
        ],
      ),
    );
  }
}
