import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction/auction_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction_info/auction_info_bloc.dart';
import 'package:whisky_hunter/src/route/tm_route.dart';
import 'package:whisky_hunter/src/utils/dependencies.dart';
import ' bloc/search_distilleries_slug.dart/search_distilleries_slug_bloc.dart';
import ' bloc/blocs/search_slug/search_slug_bloc.dart';
import ' bloc/blocs/distilleries_info/distilleries_bloc.dart';
import ' bloc/module/bloc_module.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  provideDependencies();
  BlocModule.provider();

  runApp(
    EasyLocalization(
      path: 'lib/assets/l10n',
      supportedLocales: const [
        Locale('en'),
        Locale('vi'),
      ],
      fallbackLocale: const Locale('vi'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AuctionBloc()),
        BlocProvider(create: (BuildContext context) => AuctionInfoBloc()),
        BlocProvider(create: (BuildContext context) => DistilleriesInfoBloc()),
        BlocProvider(create: (BuildContext context) => SearchSlugBloc()),
        BlocProvider(create: (BuildContext context) => DistilleriesSlugBloc()),
      ],
      child: GetMaterialApp(
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        initialRoute: TMRoute.signin.name!,
        onGenerateRoute: TMRouteExt.generateRoute,
      ),
    );
  }
}
