import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:whisky_hunter/l10n/codegen_loader.g.dart';
import 'package:whisky_hunter/src/route/tm_route.dart';
import 'package:whisky_hunter/src/utils/dependencies.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  provideDependencies();
  runApp(
      EasyLocalization(
        path: 'lib/assets/l10n',
        supportedLocales: const [
          Locale('en' ),
          Locale('vi'),
        ],
        fallbackLocale: const Locale('vi'),
        assetLoader: const CodegenLoader(),
        child: const  MyApp(),
      )
    
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      initialRoute: TMRoute.splash.name!,
      onGenerateRoute: TMRouteExt.generateRoute,
    );
  }
}
