import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:whisky_hunter/%20bloc/blocs/favorite/favorite_cubit.dart';
import 'package:whisky_hunter/src/route/tm_route.dart';
import 'package:whisky_hunter/src/utils/dependencies.dart';
import ' bloc/blocs/blocs.dart';
import 'src/constant/constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  provideDependencies();
  runApp(
    EasyLocalization(
      path: 'lib/assets/l10n',
      startLocale: const Locale('vi'),
      supportedLocales: const [
        Locale('vi'),
        Locale('en'),
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
        BlocProvider(
            create: (BuildContext context) => AuctionCubit(dio: Dio())),
        BlocProvider(
            create: (BuildContext context) => AuctionInfoCubit(dio: Dio())),
        BlocProvider(
            create: (BuildContext context) =>
                DistilleriesInfoCubit(dio: Dio())),
        BlocProvider(create: (BuildContext context) => SearchCubit(dio: Dio())),
        BlocProvider(create: (BuildContext context) => FavoriteCubit()),
      ],
      child: GetMaterialApp(
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        initialRoute: TMRoute.main.name!,
        onGenerateRoute: TMRouteExt.generateRoute,
        navigatorKey: globalManager.navigatorKey,
      ),
    );
  }
}
