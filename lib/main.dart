import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:whisky_hunter/src/route/tm_route.dart';
import 'package:whisky_hunter/src/utils/dependencies.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  provideDependencies();

  runApp(
    const  MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
     
      debugShowCheckedModeBanner: false,
      initialRoute: TMRoute.splash.name!,
      onGenerateRoute: TMRouteExt.generateRoute,
    );
  }
}
