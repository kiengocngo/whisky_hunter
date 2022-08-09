import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:whisky_hunter/src/route/tm_route.dart';
import 'package:whisky_hunter/src/utils/dependencies.dart';
import ' bloc/blocs/blocs.dart';
import ' bloc/module/bloc_module.dart';
import 'src/constant/constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
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
