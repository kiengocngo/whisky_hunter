import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:whisky_hunter/%20bloc/blocs/authen/auth_bloc.dart';
import 'package:whisky_hunter/src/data/repo/auth_repository.dart';
import 'package:whisky_hunter/src/route/tm_route.dart';
import 'package:whisky_hunter/src/utils/dependencies.dart';
import ' bloc/blocs/search_slug/search_slug_bloc.dart';
import ' bloc/blocs/distilleries_info/distilleries_bloc.dart';
import ' bloc/blocs/auction_info/auction_info_bloc.dart';
import ' bloc/blocs/auction/auction_bloc.dart';
import ' bloc/module/bloc_module.dart';
import 'src/constant/constant.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
      child: MyApp(),
    ),
  );
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final GlobalManager globalManager = Get.find();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AuctionBloc(dio: Dio())),
        BlocProvider(
            create: (BuildContext context) => AuctionInfoBloc(dio: Dio())),
        BlocProvider(
            create: (BuildContext context) => DistilleriesInfoBloc(dio: Dio())),
        BlocProvider(
            create: (BuildContext context) => SearchSlugBloc(dio: Dio())),
        BlocProvider(
            create: (BuildContext context) =>
                AuthBloc(authRepository: AuthRepository())),
      ],
      child: GetMaterialApp(
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        initialRoute: TMRoute.splash.name!,
        onGenerateRoute: TMRouteExt.generateRoute,
        navigatorKey: globalManager.navigatorKey,
      ),
    );
  }
}
