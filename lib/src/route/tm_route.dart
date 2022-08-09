import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:whisky_hunter/src/data/model/auction_data_model.dart';
import 'package:whisky_hunter/src/ui/home/auction_data_screen.dart';
import 'package:whisky_hunter/src/data/model/autction_data_slug.dart';
import 'package:whisky_hunter/src/ui/favortie/favorite_screen.dart';
import 'package:whisky_hunter/src/ui/main/main_screen.dart';
import 'package:whisky_hunter/src/ui/search/search_slug_screen.dart';
import 'package:whisky_hunter/src/ui/settings/language_setting.dart';
import 'package:whisky_hunter/src/ui/splash/onboarding_screen.dart';
import 'package:whisky_hunter/src/ui/splash/splash_screen.dart';

enum TMRoute {
  splash,
  onboarding,
  auction,
  serchslug,
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
      case TMRoute.onboarding:
        return '/onboarding';
      case TMRoute.auction:
        return '/auction';
      case TMRoute.serchslug:
        return '/searchslug';
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
      case TMRoute.onboarding:
        return GetPageRoute(
          settings: settings,
          page: () => const OnBoardingScreen(),
          transition: Transition.cupertino,
        );
      case TMRoute.auction:
        return GetPageRoute(
          settings: settings,
          page: () => const AuctionDataScreen(),
          bindings: [],
          transition: Transition.cupertino,
        );
      case TMRoute.serchslug:
        return GetPageRoute(
          settings: settings,
          page: () => const SearchSlugScreen(),
          bindings: [],
          transition: Transition.cupertino,
        );
      case TMRoute.auctionSlug:
        final dynamic args = settings.arguments;
        final AuctionDataModel auction = args[0];

        return GetPageRoute(
          settings: settings,
          bindings: [],
          page: () => AuctionDataSlug(
            auction: auction,
          ),
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
          bindings: [],
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
