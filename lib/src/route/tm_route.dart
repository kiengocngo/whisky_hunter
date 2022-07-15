import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'package:whisky_hunter/src/ui/auction_data_screen.dart';
import 'package:whisky_hunter/src/ui/autction_data_slug.dart';
import 'package:whisky_hunter/src/ui/favortie/favorite_screen.dart';
import 'package:whisky_hunter/src/ui/main/main_screen.dart';
import 'package:whisky_hunter/src/ui/settings/language_setting.dart';
import 'package:whisky_hunter/src/ui/splash/splash_screen.dart';

enum TMRoute {
  splash,
  auction,
  auctionSlug,
  main,
  setting,
  favorite,
}


extension TMRouteExt on TMRoute {
  String? get name {
    switch (this) {
      case TMRoute.splash:
      return '/splash';
      case TMRoute.auction:
        return '/auction';
      case TMRoute.auctionSlug:
        return '/auctionSlug';
      case TMRoute.main:
      return '/main';
      case TMRoute.setting:
      return '/setting';
      case TMRoute.favorite:
      return '/favorite';
      default:
        return null;
    }
  }

  static TMRoute? from(String? name) {
    for (final item in TMRoute.values) {
      if (item.name == name) {
        return item;
      }
    }
    return null;
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (TMRouteExt.from(settings.name)) {
      case TMRoute.splash: 
      return GetPageRoute(
        settings: settings,
        page: () => const SplashScreen(),
        transition: Transition.cupertino,
      );
      case TMRoute.auction:
        return GetPageRoute(
          settings: settings,
          page: () => const AuctionDataScreen(),
          bindings: [],
          transition: Transition.cupertino,
        );
      case TMRoute.auctionSlug:
        final dynamic args = settings.arguments;
        final String dt = args[0];
        final String auctionName = args[1];
        final String auctionSlug = args[2];
        final int auctionLotsCount = args[3];
        final int allAuctionsLotsCount = args[4];
        final double winningBidMax = args[5];
        final double winningBidMin = args[6];
        final double auctionTradingVolume = args[7];
        return GetPageRoute(
          settings: settings,
          bindings: [],
          page: () => AuctionDataSlug(
              dt: dt,
              auctionName: auctionName,
              auctionSlug: auctionSlug,
              auctionLotsCount: auctionLotsCount,
              allAuctionsLotsCount: allAuctionsLotsCount,
              winningBidMax: winningBidMax,
              winningBidMin: winningBidMin,
              auctionTradingVolume: auctionTradingVolume),
          transition: Transition.cupertino,
        );
        case TMRoute.main:
        return GetPageRoute(
          settings: settings,
          bindings: [],
          page: () => const MainScreen(),
        );
        case TMRoute.setting:
        return GetPageRoute(
          settings: settings,
          bindings:[],
          page: () => const Settings(),
        );
        case TMRoute.favorite:
        return GetPageRoute(
          settings: settings,
          bindings: [],
          page: () => const FavoriteScreen(),
        );
      default:
        return GetPageRoute(
            settings: settings,
            page: () => Scaffold(
                  appBar: AppBar(),
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
