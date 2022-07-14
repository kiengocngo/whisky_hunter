import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:whisky_hunter/theme/tm_colors.dart';


class TMThemeData with Diagnosticable {
  TMThemeData();

  late TextStyle textNameWhisky;
  late TextStyle textNameWhiskyBlack;
  late TextStyle learnMore;
  late TextStyle textDataAuction;
  late TextStyle textDataAuctionBlack;


  // Builds the Custom Themes, EFd on the currently defined EF Themes
  // ignore: avoid_unused_constructor_parameters
  factory TMThemeData.fromContext(BuildContext context) {
    // final ThemeData themeData = Theme.of(context);
    final TMThemeData theme = TMThemeData();

    theme.textNameWhisky = const TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
      fontSize: 20.0,
      color:TMColors.textWhite,
    );
    theme.textNameWhiskyBlack = const TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
      fontSize: 20.0,
      
    );
    theme.learnMore = const TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      fontSize: 16.0,
      color:TMColors.textWhite,
    );
    theme.textDataAuction = const TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      fontSize: 14,
      color: TMColors.textWhite,
    );
    theme.textDataAuctionBlack = const TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      fontSize: 16,
    );
  

    return theme;
  }

  
}
