import 'package:get/instance_manager.dart';
import 'package:whisky_hunter/src/constant/constant.dart';
import 'package:whisky_hunter/src/shared/app_managrer.dart';

void provideDependencies() {
  Get.put(AppManager());
  Get.lazyPut(() => GlobalManager(), fenix: true);
}


